//
//  GameViewController.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import UIKit
import Combine

class GameViewController: UIViewController {

    private let viewModel: GameVCViewModel
    private let gameView: GamePlayView?
    private let stopwatch: StopwatchTimer
    private var isGameStopped: AnyCancellable?
    weak var delegate: GameViewControllerDelegate?

    init(with viewModel: GameVCViewModel, and stopwatch: StopwatchTimer) {
        self.stopwatch = stopwatch
        self.viewModel = viewModel
        self.gameView = GamePlayView(with: viewModel.provideGameViewModel(), and: stopwatch)

        super.init(nibName: nil, bundle: nil)
        setupUI()
        bindObserver()
        use(AppTheme.self) {
            $0.view.backgroundColor = $1.backgroundColor
            $0.navigationItem.leftBarButtonItem?.tintColor = $1.textColor
            $0.reloadInputViews()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        stopwatch.resetTimer()
        isGameStopped?.cancel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark.circle"),
            style: .plain,
            target: self,
            action: #selector(closeGame))
    }

    private func bindObserver() {

        isGameStopped = viewModel.$isGameOver
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isGameOver in
                guard let self = self else {return}
                if isGameOver == .gameLost {
                    let alertController = self.viewModel.addGameOverAlertController(in: self)
                    self.present(alertController, animated: true)
                } else if isGameOver == .gameWon {
                    let alertController = self.viewModel.addGameFinishedAlertController(in: self)
                    self.present(alertController, animated: true)
                }
            })
    }

    func setupUI() {
        guard let gameView = gameView else {
            return
        }

        view.addSubview(gameView)
        gameView.frame = view.frame
        gameView.setupLevelLayout(viewModel.provideGameLevel())
    }

    @objc func closeGame() {
        stopwatch.resetTimer()
        delegate?.gameViewControllerDidRequestDismiss(self)
    }
}
