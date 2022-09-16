//
//  MainMenuViewController.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import UIKit

class MainMenuViewController: UIViewController {

    private let viewModel: MainMenuViewModel
    private let menuView: MainMenuView

    init(with viewModel: MainMenuViewModel) {
        self.viewModel = viewModel
        self.menuView = MainMenuView(with: viewModel)

        super.init(nibName: nil, bundle: nil)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome \(viewModel.setUsername())"
    }

    private func setupUI() {
        view.addSubview(menuView)
        menuView.frame = view.frame
    }
}