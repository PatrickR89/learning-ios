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
    private let viewModel: MainMenuViewModel

    init(with viewModel: MainMenuViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.backgroundColor = .red
    }
}
