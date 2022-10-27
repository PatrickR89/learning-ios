//
//  GameCardViewModel.swift
//  project-99
//
//  Created by Patrick on 24.10.2022..
//

import Foundation
import Combine

class GameCardViewModel {
    private var cancellable: AnyCancellable?
    @Published private(set) var gameCard: GameCard = GameCard(
        id: 0,
        image: "",
        color: .systemBlue,
        isVisible: false,
        isPaired: false)

    init() {
        setupBindings()
    }

    func setupCard(for card: GameCard) {
        self.gameCard = card
    }

    func setupBindings() {
        cancellable = GameCardContext.shared.$cardsPair
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] cardsPair in
                if let cardOne = cardsPair.one {
                    if self?.gameCard.id == cardOne.id {
                        self?.gameCard = cardOne
                    }
                }

                if let cardTwo = cardsPair.two {
                    if self?.gameCard.id == cardTwo.id {
                        self?.gameCard = cardTwo
                    }
                }
            })
    }

    func cardFlipped() {
        GameCardContext.shared.gameCardViewModel(self, didTapCard: gameCard)
    }
}
