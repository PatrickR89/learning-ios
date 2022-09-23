//
//  GameViewModel.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import Foundation

class GameViewModel {
    private let game: Level

    init(for level: Level) {
        self.game = level
    }

    func sendGameLevel() -> String {
        return game.rawValue
    }
}
