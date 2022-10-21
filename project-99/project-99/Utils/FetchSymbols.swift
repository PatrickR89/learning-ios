//
//  FetchSymbols.swift
//  project-99
//
//  Created by Patrick on 21.10.2022..
//

import Foundation

final class FetchSymbols {
    static func getSymbolsFromResource() -> [String] {
        guard let symbolUrl = Bundle.main.url(forResource: "symbolList", withExtension: ".txt"),
              let symbols = try? String(contentsOf: symbolUrl) else {fatalError("Symbols for game not found")}
        let cardSymbols = symbols.components(separatedBy: "\n").shuffled()
        return cardSymbols
    }
}
