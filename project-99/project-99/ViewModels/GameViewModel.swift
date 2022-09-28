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
            currentSymbols = Array(cardSymbols[0..<4])
        case .easy:
            currentSymbols = Array(cardSymbols[0..<6])
        case .mediumHard:
            currentSymbols = Array(cardSymbols[0..<8])
        case .hard:
            currentSymbols = Array(cardSymbols[0..<9])
        case .veryHard:
            currentSymbols = Array(cardSymbols[0..<12])
        case .emotionalDamage:
            currentSymbols = Array(cardSymbols[0..<16])
        }
    }

    private func setupCards() {
        var cardId: Int = 0
        for symbol in currentSymbols {
            currentCards += Array(repeating: GameCard(id: cardId, image: symbol, color: .systemBlue), count: 2)
            cardId += 1
        }
        currentCards.shuffle()
    }
}
