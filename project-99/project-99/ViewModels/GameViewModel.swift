//
//  GameViewModel.swift
//  project-99
//
//  Created by Patrick on 27.09.2022..
//

import Foundation
import UIKit

class GameViewModel {
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

    private var removedPairs: Int = 0
    private var turnsLeft: Int = 0
    private var turnsCountdown: Bool = false
    private var cardsDeckObserver: (([GameCard]) -> Void)?

    init(for level: Level) {
        setupSymbols(gameDifficulty: level)
    }

    private func cardsValueInDeckDidChange() {
        guard let cardsDeckObserver = cardsDeckObserver else {
            return
        }
        cardsDeckObserver(cardsDeck)
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

    private func setupCards() {
        var cardId: Int = 0
        for symbol in currentSymbols {

            cardsDeck.append(
                GameCard(
                    id: cardId,
                    image: symbol,
                    color: .systemBlue,
                    isVisible: false,
                    isPaired: false))
            cardId += 1
        }
        cardsDeck.shuffle()
    }

    func bindCardsDeckObserver(_ closure: @escaping ([GameCard]) -> Void) {
        cardsDeckObserver = closure
        cardsValueInDeckDidChange()
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

        if card.isPaired != false {return}

        if selectedCardOne == nil {
            guard let index = cardsDeck.firstIndex(where: {$0.id == card.id}) else {return}
            cardsDeck[index].isVisible = true
            selectedCardOne = card
            return
        }

        if selectedCardTwo == nil && selectedCardOne?.id != card.id {
            guard let index = cardsDeck.firstIndex(where: {$0.id == card.id}) else {return}
            cardsDeck[index].isVisible = true
            selectedCardTwo = card
        }
    }

    func resetSelectedCards() {
        guard let cardOne = selectedCardOne,
              let cardTwo = selectedCardTwo,
              let firstIndex = cardsDeck.firstIndex(where: {$0.id == cardOne.id}),
              let secondIndex = cardsDeck.firstIndex(where: {$0.id == cardTwo.id}) else {return}
        cardsDeck[firstIndex].isVisible = false
        cardsDeck[secondIndex].isVisible = false
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

        if selectedCardOne.image == selectedCardTwo.image && selectedCardOne.color == selectedCardTwo.color {
            if let firstCardIndex = cardsDeck.firstIndex(where: {$0.id == selectedCardOne.id}) {
                cardsDeck[firstCardIndex].isPaired = true
                cardsDeck[firstCardIndex].color = .lightGray
            }

            if let secondCardIndex = cardsDeck.firstIndex(where: {$0.id == selectedCardTwo.id}) {
                cardsDeck[secondCardIndex].isPaired = true
                cardsDeck[secondCardIndex].color = .lightGray
            }
            print("match")
            // add visual removal of cards - change to a new view of collection cell to maintain layout
            removedPairs += 1
            resetSelectedCards()
        } else {
            // turn cards on their backs

            print("mismatch")
            if turnsCountdown {
                turnsLeft -= 1
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.resetSelectedCards()
            }
        }

    }
}
