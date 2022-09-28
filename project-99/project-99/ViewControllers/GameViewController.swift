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
        print(viewModel.sendGameLevel())
    }
}
