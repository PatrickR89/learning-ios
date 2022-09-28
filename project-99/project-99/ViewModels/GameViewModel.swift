//
//  GameViewModel.swift
//  project-99
//
//  Created by Patrick on 27.09.2022..
//

import Foundation

class GameViewModel {
    var currentGameCards = [String]()

    init(for level: Level) {
        setupCards(gameDifficulty: level)
    }

    func fetchSymbols() -> [String] {
        guard let symbolUrl = Bundle.main.url(forResource: "symbolList", withExtension: ".txt"),
              let symbols = try? String(contentsOf: symbolUrl) else {fatalError("Symbols for game not found")}
        let cardSymbols = symbols.components(separatedBy: "\n").shuffled()
        return cardSymbols
    }

    func setupCards(gameDifficulty: Level) {

        let cardSymbols = fetchSymbols()
        switch gameDifficulty {

        case .veryEasy:
            currentGameCards = Array(cardSymbols[0..<4])
        case .easy:
            currentGameCards = Array(cardSymbols[0..<6])
        case .mediumHard:
            currentGameCards = Array(cardSymbols[0..<8])
        case .hard:
            currentGameCards = Array(cardSymbols[0..<9])
        case .veryHard:
            currentGameCards = Array(cardSymbols[0..<12])
        case .emotionalDamage:
            currentGameCards = Array(cardSymbols[0..<16])
        }

        print(currentGameCards)
    }
}
