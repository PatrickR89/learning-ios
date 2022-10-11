//
//  GameViewModel.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import UIKit

class GameVCViewModel {
    private let game: Level
    private var playGameViewModel: GameViewModel

    private var isGameOver = false {
        didSet {
            gameOverValueDidChange()
        }
    }

    private var gameObserver: ((Bool) -> Void)?

    init(for level: Level) {
        self.game = level
        self.playGameViewModel = GameViewModel(for: level)
        self.playGameViewModel.delegate = self
    }

    private func gameOverValueDidChange() {
        guard let observeGame = gameObserver else {
            return
        }
        observeGame(isGameOver)
    }

    func observeGameState(_ closure: @escaping (Bool) -> Void) {
        self.gameObserver = closure
        gameOverValueDidChange()
    }

    func sendGameLevel() -> Level {
        return game
    }

    func provideInitializedViewModel() -> GameViewModel {
        return playGameViewModel
    }

    func addGameOverAlertController(in viewController: GameViewController) -> UIAlertController {
        let alertController = UIAlertController().createGameOverAlertController(in: viewController, with: self)
        return alertController
    }
}

extension GameVCViewModel: GameViewModelDelegate {
    func gameViewModelDidFinishGame(_ viewModel: GameViewModel) {
        return
    }

    func gameViewModelDidEndGame(_ viewModel: GameViewModel) {
        self.isGameOver = true
    }
}
