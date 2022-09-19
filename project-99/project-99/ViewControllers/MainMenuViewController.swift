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
    private let settingsViewModel: SettingsViewModel

    init(with viewModel: MainMenuViewModel) {
        self.viewModel = viewModel
        self.menuView = MainMenuView(with: viewModel)
        self.settingsViewModel = SettingsViewModel(forUser: viewModel.returnUser(), in: viewModel.realm)

        super.init(nibName: nil, bundle: nil)
        setupUI()
        settingsViewModel.loadUserSettings()
        title = "Welcome \(viewModel.setUsername())"
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
        menuView.delegate = self
    }
}

extension MainMenuViewController: MainMenuViewDelegate {
    func mainMenuView(_ view: MainMenuView, didTapOnSettingsForUser user: User) {

        let viewController = SettingsViewController(with: settingsViewModel)
        viewController.delegate = self
        let navController = UINavigationController()

        navController.viewControllers = [viewController]
        present(navController, animated: true)
    }
}

extension MainMenuViewController: SettingsViewControllerDelegate {
    func settingsViewController(_ viewController: SettingsViewController, didRecieveUpdatedName username: String) {
        title = "Welcome \(username)"
    }
}
