//
//  GameViewModel.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import UIKit
import Combine

class GameVCViewModel {
    private let game: Level
    private var playGameViewModel: GameViewModel

    @Published private(set) var isGameOver: EndGame = .inGame

    init(for level: Level, with stopwatch: Stopwatch) {
        self.game = level
        self.playGameViewModel = GameViewModel(for: level, with: stopwatch)
        self.playGameViewModel.delegate = self
    }

    func provideGameLevel() -> Level {
        return game
    }

    func provideGameViewModel() -> GameViewModel {
        return playGameViewModel
    }

    func addGameOverAlertController(in viewController: GameViewController) -> UIAlertController {
        let alertController = UIAlertController().createGameOverAlertController(in: viewController, with: self)
        return alertController
    }

    func addGameFinishedAlertController(in viewController: GameViewController) -> UIAlertController {
        let alertController = UIAlertController().createGameWonAlertController(in: viewController, with: self)
        return alertController
    }
}

extension GameVCViewModel: GameViewModelDelegate {
    func gameViewModelDidEndGame(_ viewModel: GameViewModel, with result: EndGame) {
        self.isGameOver = result
    }
}
