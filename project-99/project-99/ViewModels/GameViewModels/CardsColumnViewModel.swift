//
//  CardsColumnViewModel.swift
//  project-99
//
//  Created by Patrick on 24.10.2022..
//

import Foundation
import Combine

class CardsColumnViewModel {
    @Published private(set) var cards = [GameCard]()
    private(set) var level: Level

    init(in level: Level) {
        self.level = level
    }

    func setupCards(with cards: [GameCard]) {
        self.cards = cards
    }
}
