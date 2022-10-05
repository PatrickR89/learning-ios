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
    private var currentCards = [GameCard]()

    private var selectedCardOne: GameCard?
    private var selectedCardTwo: GameCard? {
        didSet {
            compareCards()
        }
    }

    private var removedPairs: Int = 0
    private var turnsLeft: Int = 0
    private var turnsCountdown: Bool = false
    weak var delegate: GameViewModelDelegate?

    init(for level: Level) {
        setupSymbols(gameDifficulty: level)
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

            currentCards.append(GameCard(id: cardId, image: symbol, color: .systemBlue))
            cardId += 1
        }
        currentCards.shuffle()

        print(currentCards)
    }

    func countCardsLength() -> Int {
        return currentCards.count
    }

    func returnCardForIndex(at index: Int) -> GameCard {
        return currentCards[index]
    }

    func selectCard(card: GameCard) {
        if  selectedCardOne != nil {
            if selectedCardTwo == nil && selectedCardOne?.id != card.id {
                selectedCardTwo = card
            }
        } else {
            selectedCardOne = card
        }
    }

    func resetSelectedCards() {
        selectedCardOne = nil
        selectedCardTwo = nil
    }

    func compareCards() {
        guard let selectedCardOne = selectedCardOne,
              let selectedCardTwo = selectedCardTwo else {
            return
        }
        if selectedCardOne.image == selectedCardTwo.image && selectedCardOne.color == selectedCardTwo.color {
            if let firstCardIndex = currentCards.firstIndex(where: {$0.id == selectedCardOne.id}) {
                currentCards.remove(at: firstCardIndex)
                delegate?.gameViewModel(self, didRemoveCardsPairAt: firstCardIndex)
            }

            if let secondCardIndex = currentCards.firstIndex(where: {$0.id == selectedCardTwo.id}) {
                currentCards.remove(at: secondCardIndex)
                delegate?.gameViewModel(self, didRemoveCardsPairAt: secondCardIndex)
            }
            print("match")
            // add visual removal of cards - change to a new view of collection cell to maintain layout
            removedPairs += 1
        } else {
            // turn cards on their backs
            print("mismatch")
            if turnsCountdown {
                turnsLeft -= 1
            }
        }

        resetSelectedCards()
    }
}
