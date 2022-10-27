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

    weak var delegate: MainMenuViewDelegate?

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
        gameButton.setupInView(forView: self, withName: "New Game", andAction: #selector(openNewGame))
        statsButton.setupInView(forView: self, withName: "Stats", andAction: #selector(openStats))
        settingsButton.setupInView(forView: self, withName: "Settings", andAction: #selector(openSettings))
        logoutButton.setupInView(forView: self, withName: "Logout", andAction: #selector(logout))

        let buttons: [UIButton] = [gameButton, statsButton, settingsButton, logoutButton]
        stackView.arrangeView(withButtons: buttons)
        stackView.setupConstraints(forView: self)
    }

    @objc func openSettings() {
        delegate?.mainMenuView(self, didTapOnSettingsForUser: viewModel.provideUser())
    }

    @objc func openStats() {
        delegate?.mainMenuView(self, didTapOnStatsForUser: viewModel.provideUser())
    }

    @objc func openNewGame() {
        delegate?.mainMenuView(self, didTapOnNewGameForUser: viewModel.provideUser())
    }

    @objc func logout() {
        delegate?.mainMenuViewDidLogout(self)
    }
}
