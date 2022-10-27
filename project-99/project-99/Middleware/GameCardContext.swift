//
//  GameCardContext.swift
//  project-99
//
//  Created by Patrick on 27.10.2022..
//

import Foundation
import Combine

enum CardPosition {
    case first
    case second
}

class GameCardContext {
    static let shared = GameCardContext()

    @Published private(set) var cardsPair = CardsPair(one: nil, two: nil)

    weak var delegate: GameCardContextDelegate?

    func gameCardViewModel(_ viewModel: GameCardViewModel, didTapCard card: GameCard) {
        delegate?.gameCardsContext( self, didReceiveTapForCard: card)
    }

    func setCards(with card: GameCard?, in position: CardPosition) {
        switch position {
        case .first:
            self.cardsPair.one = card
        case .second:
            self.cardsPair.two = card
        }
    }
}

protocol GameCardContextDelegate: AnyObject {
    func gameCardsContext(_ context: GameCardContext, didReceiveTapForCard card: GameCard)
}
