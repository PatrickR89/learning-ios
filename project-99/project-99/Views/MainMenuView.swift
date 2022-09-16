//
//  MainMenuView.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import UIKit

class MainMenuView: UIView {

    private let gameButton = UIButton()
    private let statsButton = UIButton()
    private let settingsButton = UIButton()
    private let stackView = UIStackView()
    private let viewModel: MainMenuViewModel

    weak var delegate: MainMenuViewDelegate?

    init(with viewModel: MainMenuViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        gameButton.setTitle("New Game", for: .normal)
        statsButton.setTitle("Stats", for: .normal)
        settingsButton.setTitle("Settings", for: .normal)

        settingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)

        let buttons: [UIButton] = [gameButton, statsButton, settingsButton]
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .top
        stackView.spacing = 20
        stackView.arrangeView(with: buttons)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75)
        ])
    }

    @objc func openSettings() {
        delegate?.mainMenuView(self, didTapOnSettingsForUser: viewModel.returnUserId())
    }
}
