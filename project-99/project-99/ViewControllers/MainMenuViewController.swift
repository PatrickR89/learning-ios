//
//  MainMenuViewController.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import UIKit
import Themes

class MainMenuViewController: UIViewController {

    private let viewModel: MainMenuViewModel
    private(set) var menuView: MainMenuView
    // coordinator provided only for MainCoordinator reference to remove MenuCoordinator on MainMenuVC lifecycle end
    weak var coordinator: MenuCoordinator?

    init(with viewModel: MainMenuViewModel) {
        self.viewModel = viewModel
        self.menuView = MainMenuView(with: viewModel)

        super.init(nibName: nil, bundle: nil)
        setupUI()
        use(AppTheme.self) {
            $0.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: $1.textColor]
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        changeTitle(with: viewModel.setUsername())
    }

    private func setupUI() {
        view.addSubview(menuView)
        menuView.frame = view.frame
    }

    func changeTitle(with username: String) {
        title = "Welcome \(username)"
    }
}
