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

    func setupCard(for card: GameCard) {
        self.gameCard = card
    }

    func cardFlipped() {
        let response = GameCardContext.shared.gameCardViewModel(self, didTapCard: gameCard)
        if response.0 == gameCard.id {
            gameCard.isVisible = response.1.isVisible
            gameCard.isPaired = response.1.isPaired
            gameCard.color = response.1.color
        }
    }
}
