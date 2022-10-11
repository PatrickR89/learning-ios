//
//  GameViewController.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import UIKit

class GameViewController: UIViewController {

    private let viewModel: GameVCViewModel
    private let gameView: GameView

    init(with viewModel: GameVCViewModel) {
        self.viewModel = viewModel
        self.gameView = GameView(with: viewModel.provideInitializedViewModel())

        super.init(nibName: nil, bundle: nil)
        setupUI()
        bindObserver()
        use(AppTheme.self) {
            $0.view.backgroundColor = $1.backgroundColor
            $0.reloadInputViews()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeGame))
    }

    private func bindObserver() {
        viewModel.observeGameState { isGameOver in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                if isGameOver == .gameLost {
                    let alertController = self.viewModel.addGameOverAlertController(in: self)
                    self.present(alertController, animated: true)
                } else if isGameOver == .gameWon {
                    let alertController = self.viewModel.addGameFinishedAlertController(in: self)
                    self.present(alertController, animated: true)
                }
            }
        }
    }

    func setupUI() {
        view.addSubview(gameView)
        gameView.frame = view.frame
        gameView.configCollectionViewLayout(for: viewModel.sendGameLevel())
    }

    @objc func closeGame() {
        self.dismiss(animated: true)
    }
}
