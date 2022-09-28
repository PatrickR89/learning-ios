//
//  GameViewModel.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import Foundation

class GameVCViewModel {
    private let game: Level
    private var playGameViewModel: GameViewModel

    init(for level: Level) {
        self.game = level
        self.playGameViewModel = GameViewModel(for: level)
    }

    func sendGameLevel() -> String {
        return game.rawValue
    }

    func provideInitializedViewModel() -> GameViewModel {
        return playGameViewModel
    }
}
