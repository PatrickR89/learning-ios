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
    private var playGameViewModel: GamePlayViewModel

    @Published private(set) var isGameOver: EndGame = .inGame

    init(for level: Level, with stopwatch: Stopwatch) {
        self.game = level
        self.playGameViewModel = GamePlayViewModel(for: level, with: stopwatch)
        self.playGameViewModel.delegate = self
    }

    func provideGameLevel() -> Level {
        return game
    }

    func provideGameViewModel() -> GamePlayViewModel {
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

extension GameVCViewModel: GamePlayViewModelDelegate {
    func gamePlayViewModelDidEndGame(_ viewModel: GamePlayViewModel, with result: EndGame) {
        self.isGameOver = result
    }
}
