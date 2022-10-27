//
//  GameCardContext.swift
//  project-99
//
//  Created by Patrick on 27.10.2022..
//

import Foundation

class GameCardContext {
    static let shared = GameCardContext()
    weak var delegate: GameCardContextDelegate?
    func gameCardViewModel(_ viewModel: GameCardViewModel, didTapCard card: GameCard) -> (Int, GameCard) {
        guard let response = delegate?.gameCardsContext(self, didReceiveTapForCard: card) else { fatalError("error in card middleware")}
        return response
    }
}

protocol GameCardContextDelegate: AnyObject {
    func gameCardsContext(_ context: GameCardContext, didReceiveTapForCard card: GameCard) -> (Int, GameCard)
}
