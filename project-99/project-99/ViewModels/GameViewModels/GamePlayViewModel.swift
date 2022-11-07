//
//  GamePlayViewModel.swift
//  project-99
//
//  Created by Patrick on 24.10.2022..
//

import UIKit

class GamePlayViewModel {

    private var stopwatch: StopwatchTimer
    private(set) var gameLevel: Level
    private var currentSymbols = [String]() {
        didSet {
            setupCards()
        }
    }
    private(set) var cardsDeck = [GameCard]()

    var assignedCardsDeck = [[GameCard]]()

    private var selectedCardOne: GameCard?
    private var selectedCardTwo: GameCard? {
        didSet {
            compareCards()
        }
    }
    @Published private(set) var turns = TurnsCountdown(isActive: false, value: 0) {
        didSet {
            endGameIfTurnsDepleted()
        }
    }
    private var removedPairs: Int = 0

    weak var delegate: GamePlayViewModelDelegate?

    init(for level: Level, with stopwatch: StopwatchTimer) {
        self.gameLevel = level
        self.stopwatch = stopwatch
        setupSymbols(gameDifficulty: level)
        RealmDataService.shared.updateTotalGames()
        GameCardContext.shared.delegate = self
        GameCardContext.shared.setCards(with: nil, in: .first)
        GameCardContext.shared.setCards(with: nil, in: .second)
        self.stopwatch.startTimer()
    }

    private func setupSymbols(gameDifficulty: Level) {

        let cardSymbols = FetchSymbols.getSymbolsFromResource().filter {
            $0 != ""
        }

        switch gameDifficulty {

        case .veryEasy:
            currentSymbols = Array(cardSymbols[0..<4]) + Array(cardSymbols[0..<4])
        case .easy:
            currentSymbols = Array(cardSymbols[0..<6]) + Array(cardSymbols[0..<6])
        case .mediumHard:
            currentSymbols = Array(cardSymbols[0..<8]) + Array(cardSymbols[0..<8])
            turns.isActive = true
            turns.value = 30
        case .hard:
            currentSymbols = Array(cardSymbols[0..<9]) + Array(cardSymbols[0..<9])
            turns.isActive = true
            turns.value = 30
        case .veryHard:
            currentSymbols = Array(cardSymbols[0..<12]) + Array(cardSymbols[0..<12])
            turns.isActive = true
            turns.value = 15
        case .emotionalDamage:
            currentSymbols = Array(cardSymbols[0..<16]) + Array(cardSymbols[0..<16])
            turns.isActive = true
            turns.value = 10
        }
    }

    private func createColors() -> [UIColor] {
        var colors: [UIColor] = [.blue, .cyan, .green,
                                 .orange, .yellow, .orange,
                                 .red, .magenta, .purple,
                                 .brown, .systemIndigo, .systemMint,
                                 .systemTeal, .darkGray,
                                 .systemPink, .systemRed]
        colors.shuffle()
        return colors
    }

    private func setupCards() {
        var cardId: Int = 0
        let colors = createColors()
        let symbols = Array(Set(currentSymbols))

        for symbol in currentSymbols {
            var color: UIColor = .systemBlue

            if RealmDataService.shared.loadMulticolorState() {
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
        assignCards()
    }

    func assignCards() {
        let tempCards = cardsDeck.shuffled()
        let gridLayout = GridLayout(gameLevel)
        switch gridLayout.columns {
        case 2:
            self.assignedCardsDeck.append(Array(tempCards[0..<gridLayout.rows]))
            self.assignedCardsDeck.append(Array(tempCards[(gridLayout.rows)..<(tempCards.count)]))
        case 3:
            self.assignedCardsDeck.append(Array(tempCards[0..<gridLayout.rows]))
            self.assignedCardsDeck.append(Array(tempCards[(gridLayout.rows)..<(gridLayout.rows * 2)]))
            self.assignedCardsDeck.append(Array(tempCards[(gridLayout.rows * 2)..<(tempCards.count)]))
        case 4:
            self.assignedCardsDeck.append(Array(tempCards[0..<gridLayout.rows]))
            self.assignedCardsDeck.append(Array(tempCards[(gridLayout.rows)..<(gridLayout.rows * 2)]))
            self.assignedCardsDeck.append(Array(tempCards[(gridLayout.rows * 2)..<(gridLayout.rows * 3)]))
            self.assignedCardsDeck.append(Array(tempCards[(gridLayout.rows * 3)..<(tempCards.count)]))
        default:
            break
        }
    }

    func selectCard( at index: Int) {

        if turns.isActive && turns.value <= 0 {return}

        if cardsDeck[index].isPaired == true {return}
        if cardsDeck[index].isVisible == true {return}

        if selectedCardOne == nil {
            cardsDeck[index].isVisible = true
            selectedCardOne = cardsDeck[index]
            GameCardContext.shared.setCards(with: cardsDeck[index], in: .first)
            return
        }

        if selectedCardTwo == nil && selectedCardOne?.id != cardsDeck[index].id {
            cardsDeck[index].isVisible = true
            selectedCardTwo = cardsDeck[index]
            GameCardContext.shared.setCards(with: cardsDeck[index], in: .first)
        }
    }

    func resetCardsSelection() {
        guard let cardOne = selectedCardOne,
              let cardTwo = selectedCardTwo,
              let firstIndex = cardsDeck.firstIndex(where: {$0.id == cardOne.id}),
              let secondIndex = cardsDeck.firstIndex(where: {$0.id == cardTwo.id}) else {return}
        cardsDeck[firstIndex].isVisible = false
        cardsDeck[secondIndex].isVisible = false
        GameCardContext.shared.setCards(with: cardsDeck[firstIndex], in: .first)
        GameCardContext.shared.setCards(with: cardsDeck[secondIndex], in: .second)
        selectedCardOne = nil
        selectedCardTwo = nil
        GameCardContext.shared.setCards(with: nil, in: .first)
        GameCardContext.shared.setCards(with: nil, in: .second)
    }

    func compareCards() {
        guard let selectedCardOne = selectedCardOne,
              let selectedCardTwo = selectedCardTwo else {
            return
        }

        RealmDataService.shared.updateTotalSelectedPairs()

        if selectedCardOne.image == selectedCardTwo.image && selectedCardOne.color == selectedCardTwo.color {
            if let firstCardIndex = cardsDeck.firstIndex(where: {$0.id == selectedCardOne.id}) {
                cardsDeck[firstCardIndex].isPaired = true
                GameCardContext.shared.setCards(with: cardsDeck[firstCardIndex], in: .first)
            }

            if let secondCardIndex = cardsDeck.firstIndex(where: {$0.id == selectedCardTwo.id}) {
                cardsDeck[secondCardIndex].isPaired = true
                GameCardContext.shared.setCards(with: cardsDeck[secondCardIndex], in: .second)
            }
            removedPairs += 1
            RealmDataService.shared.updatePairedCards()
            resetCardsSelection()
            endGameIfCardsDepleted()
        } else {
            if turns.isActive {
                turns.value -= 1
            }

            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.resetCardsSelection()
            }
        }
    }

    private func endGameIfTurnsDepleted() {
        if turns.isActive && turns.value <= 0 {
            stopwatch.resetTimer()
            self.resetCardsSelection()
            delegate?.gamePlayViewModelDidEndGame(self, with: .gameLost)
        }
    }

    private func endGameIfCardsDepleted() {
        if removedPairs == cardsDeck.count / 2 && removedPairs != 0 {
            RealmDataService.shared.updateGamesWon()
            stopwatch.stopAndSaveTime(for: gameLevel)
            self.resetCardsSelection()
            delegate?.gamePlayViewModelDidEndGame(self, with: .gameWon)
        }
    }
}

extension GamePlayViewModel: GameCardContextDelegate {
    func gameCardsContext(_ context: GameCardContext, didReceiveTapForCard card: GameCard) {
        guard let index = cardsDeck.firstIndex(where: {$0.id == card.id}) else {
            fatalError("error in cards")
        }
        selectCard(at: index)
    }
}
