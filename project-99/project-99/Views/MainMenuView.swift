//
//  MainMenuView.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import UIKit
import Themes

class MainMenuView: UIView {

    private let gameButton = UIButton()
    private let statsButton = UIButton()
    private let settingsButton = UIButton()
    private let logoutButton = UIButton()
    private let stackView = UIStackView()
    private let viewModel: MainMenuViewModel

    weak var action: MainMenuViewModelDelegate?

    init(with viewModel: MainMenuViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()

        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
            $0.reloadInputViews()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.addSubview(stackView)
        gameButton.setupInView(self, withName: "New Game", andAction: #selector(openNewGame))
        statsButton.setupInView(self, withName: "Stats", andAction: #selector(openStats))
        settingsButton.setupInView(self, withName: "Settings", andAction: #selector(openSettings))
        logoutButton.setupInView(self, withName: "Logout", andAction: #selector(logout))

        let buttons: [UIButton] = [gameButton, statsButton, settingsButton, logoutButton]
        stackView.arrangeButtons(buttons)
        stackView.setupConstraints(self)
    }

    @objc func openSettings() {
        viewModel.openSettings()
    }

    @objc func openStats() {
        viewModel.openStats()
    }

    @objc func openNewGame() {
        viewModel.openNewGame()
    }

    @objc func logout() {
        viewModel.logout()
    }
}
