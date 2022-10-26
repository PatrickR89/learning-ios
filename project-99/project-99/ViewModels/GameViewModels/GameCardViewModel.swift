//
//  GameCardViewModel.swift
//  project-99
//
//  Created by Patrick on 24.10.2022..
//

import Foundation
import Combine

class GameCardViewModel {
    @Published private(set) var gameCard: GameCard = GameCard(
        id: 0,
        image: "",
        color: .systemBlue,
        isVisible: false,
        isPaired: false)

    func flipCard(for card: GameCard) {
        self.gameCard = card
    }
}
