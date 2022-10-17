//
//  GameViewModel.swift
//  project-99
//
//  Created by Patrick on 27.09.2022..
//

import UIKit

class GameViewModel {

    private var stopwatch: Stopwatch
    private var gameLevel: Level
    private var currentSymbols = [String]() {
        didSet {
            setupCards()
        }
    }
    private var cardsDeck = [GameCard]() {
        didSet {
            cardsValueInDeckDidChange()
        }
    }

    private var selectedCardOne: GameCard?
    private var selectedCardTwo: GameCard? {
        didSet {
            compareCards()
        }
    }

    private(set) var cardOneIndex = IndexPath(item: 0, section: 0)
    private(set) var cardTwoIndex = IndexPath(item: 0, section: 0)

    private var removedPairs: Int = 0
    private var turnsLeft: Int = 0 {
        didSet {
            remainingTurnsValueDidChange()
            endGameWithLose()
        }
    }
    private var turnsCountdown: Bool = false {
        didSet {
            remainingTurnsValueDidChange()
        }
    }
    private var cardsDeckObserver: (([GameCard]) -> Void)?
    private var turnsLeftObserver: ((Bool, Int) -> Void)?

    weak var delegate: GameViewModelDelegate?

    init(for level: Level, with stopwatch: Stopwatch) {
        self.gameLevel = level
        self.stopwatch = stopwatch
        setupSymbols(gameDifficulty: level)
        RealmDataService.shared.updateTotalGames()
        self.stopwatch.startTimer()
    }

    private func cardsValueInDeckDidChange() {
        guard let cardsDeckObserver = cardsDeckObserver else {
            return
        }
        cardsDeckObserver(cardsDeck)
    }

    private func remainingTurnsValueDidChange() {
        guard let turnsLeftObserver = turnsLeftObserver else {
            return
        }
        turnsLeftObserver(turnsCountdown, turnsLeft)
    }

    private func fetchSymbols() -> [String] {
        guard let symbolUrl = Bundle.main.url(forResource: "symbolList", withExtension: ".txt"),
              let symbols = try? String(contentsOf: symbolUrl) else {fatalError("Symbols for game not found")}
        let cardSymbols = symbols.components(separatedBy: "\n").shuffled()
        return cardSymbols
    }

    private func setupSymbols(gameDifficulty: Level) {

        let cardSymbols = fetchSymbols()
        switch gameDifficulty {

        case .veryEasy:
            currentSymbols = Array(cardSymbols[0..<4]) + Array(cardSymbols[0..<4])
        case .easy:
            currentSymbols = Array(cardSymbols[0..<6]) + Array(cardSymbols[0..<6])
        case .mediumHard:
            currentSymbols = Array(cardSymbols[0..<8]) + Array(cardSymbols[0..<8])
            turnsLeft = 30
            turnsCountdown = true
        case .hard:
            currentSymbols = Array(cardSymbols[0..<9]) + Array(cardSymbols[0..<9])
            turnsLeft = 30
            turnsCountdown = true
        case .veryHard:
            currentSymbols = Array(cardSymbols[0..<12]) + Array(cardSymbols[0..<12])
            turnsLeft = 15
            turnsCountdown = true
        case .emotionalDamage:
            currentSymbols = Array(cardSymbols[0..<16]) + Array(cardSymbols[0..<16])
            turnsLeft = 10
            turnsCountdown = true
        }
    }

    private func createColors() -> [UIColor] {
        var colors: [UIColor] = [.blue, .cyan, .green,
                                 .orange, .yellow, .orange,
                                 .red, .magenta, .purple,
                                 .brown, .systemIndigo, .systemMint,
                                 .systemTeal, .black, .darkGray,
                                 .systemPink]
        colors.shuffle()
        return colors
    }

    private func setupCards() {
        var cardId: Int = 0
        let colors = createColors()
        let symbols = Array(Set(currentSymbols))

        for symbol in currentSymbols {
            var color: UIColor = .systemBlue

            if RealmDataService.shared.loadMulticolorValue() {
                if let index = symbols.firstIndex(where: {$0 == symbol}) {
                    color = colors[index]
                }
            }

            cardsDeck.append(
                GameCard(
                    id: cardId,
                    image: symbol,
                    color: color,
                    isVisible: false,
                    isPaired: false))
            cardId += 1
        }
        cardsDeck.shuffle()
    }

    func observeCardDeck(_ closure: @escaping ([GameCard]) -> Void) {
        cardsDeckObserver = closure
        cardsValueInDeckDidChange()
    }

    func observeRemainigTurns(_ closure: @escaping (Bool, Int) -> Void) {
        turnsLeftObserver = closure
        remainingTurnsValueDidChange()
    }

    func countCardsLength() -> Int {
        return cardsDeck.count
    }

    func returnCardForIndex(at index: Int) -> GameCard {
        return cardsDeck[index]
    }

    func returnIndexForCard(card: GameCard) -> Int {
        guard let index = cardsDeck.firstIndex(where: {$0.id == card.id}) else {return 0}
        return index
    }

    func selectCard(card: GameCard, at index: Int) {

        if turnsCountdown && turnsLeft <= 0 {return}

        if card.isPaired == true {return}
        if card.isVisible == true {return}

        if selectedCardOne == nil {
            guard let index = cardsDeck.firstIndex(where: {$0.id == card.id}) else {return}
            cardsDeck[index].isVisible = true
            selectedCardOne = card
            cardOneIndex = IndexPath(item: index, section: 0)
            return
        }

        if selectedCardTwo == nil && selectedCardOne?.id != card.id {
            guard let index = cardsDeck.firstIndex(where: {$0.id == card.id}) else {return}
            cardsDeck[index].isVisible = true
            selectedCardTwo = card
            cardTwoIndex = IndexPath(item: index, section: 0)
        }
    }

    func resetCardsSelection() {
        guard let cardOne = selectedCardOne,
              let cardTwo = selectedCardTwo,
              let firstIndex = cardsDeck.firstIndex(where: {$0.id == cardOne.id}),
              let secondIndex = cardsDeck.firstIndex(where: {$0.id == cardTwo.id}) else {return}
        cardsDeck[firstIndex].isVisible = false
        cardsDeck[secondIndex].isVisible = false
        cardOneIndex = IndexPath(item: firstIndex, section: 0)
        cardTwoIndex = IndexPath(item: secondIndex, section: 0)
        selectedCardOne = nil
        selectedCardTwo = nil
    }

    func keepCardRevealed(for card: GameCard) -> Bool {
        return card.isVisible || card.isPaired
    }

    func compareCards() {
        guard let selectedCardOne = selectedCardOne,
              let selectedCardTwo = selectedCardTwo else {
            return
        }

        RealmDataService.shared.updateTotalSelectedPairs()

        if selectedCardOne.image == selectedCardTwo.image && selectedCardOne.color == selectedCardTwo.color {
            if let firstCardIndex = cardsDeck.firstIndex(where: {$0.id == selectedCardOne.id}) {
                cardOneIndex = IndexPath(item: firstCardIndex, section: 0)
                cardsDeck[firstCardIndex].isPaired = true
                cardsDeck[firstCardIndex].color = .lightGray
            }

            if let secondCardIndex = cardsDeck.firstIndex(where: {$0.id == selectedCardTwo.id}) {
                cardTwoIndex = IndexPath(item: secondCardIndex, section: 0)
                cardsDeck[secondCardIndex].isPaired = true
                cardsDeck[secondCardIndex].color = .lightGray
            }
            removedPairs += 1
            RealmDataService.shared.updatePairedCards()
            resetCardsSelection()
            endGameIfWin()
        } else {

            if turnsCountdown {
                turnsLeft -= 1
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.resetCardsSelection()
            }
        }
    }

    private func endGameWithLose() {
        if turnsCountdown && turnsLeft <= 0 {
            stopwatch.resetTimer()
            delegate?.gameViewModelDidEndGame(self, with: .gameLost)
        }
    }

    private func endGameIfWin() {
        if removedPairs == cardsDeck.count / 2 && removedPairs != 0 {
            RealmDataService.shared.updateGamesWon()
            stopwatch.stopAndSaveTime(for: gameLevel)
            delegate?.gameViewModelDidEndGame(self, with: .gameWon)
        }
    }
}
