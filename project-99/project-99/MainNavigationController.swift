//
//  MainNavigationController.swift
//  project-99
//
//  Created by Patrick on 27.10.2022..
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginViewController()
    }

    func setupLoginViewController() {
        let loginViewController = LoginViewController()
        loginViewController.delegate = self
        self.setViewControllers([loginViewController], animated: true)
    }
}

extension MainNavigationController: LoginViewControllerDelegate {
    func loginViewController(
        _ viewController: LoginViewController,
        didLogUserInViewModel viewModel: MainMenuViewModel) {

            let mainMenuViewController = MainMenuViewController(with: viewModel)
            mainMenuViewController.delegate = self
            self.setViewControllers([mainMenuViewController], animated: true)
        }
}

extension MainNavigationController: MainMenuViewControllerDelegate {
    func mainMenuViewControllerDidOpenNewGame(_ viewController: MainMenuViewController) {
        let viewController = NewGameViewController()
        viewController.delegate = self
        self.pushViewController(viewController, animated: true)
    }

    func mainMenuViewController(
        _ viewController: MainMenuViewController,
        didReciveAccountDeletionFrom settingsViewController: SettingsViewController) {
            RealmDataService.shared.deleteAccount()
            UserContainer.shared.saveUser(with: nil)
            setupLoginViewController()
        }

    func mainMenuViewControllerDidRecieveLogout(_ viewController: MainMenuViewController) {
        UserContainer.shared.saveUser(with: nil)
        setupLoginViewController()
    }
}

extension MainNavigationController: NewGameViewControllerDelegate {
    func newGameViewController(
        _ viewController: NewGameViewController,
        didStartNewGameWithViewModel viewModel: GameVCViewModel,
        and stopwatch: Stopwatch) {

            let viewController = GameViewController(with: viewModel, and: stopwatch)
            viewController.delegate = self
            self.pushViewController(viewController, animated: true)
        }

    func newGameViewControllerDidRequestDismiss(_ viewController: NewGameViewController) {
        self.popViewController(animated: true)
    }
}

extension MainNavigationController: GameViewControllerDelegate {
    func gameViewControllerDidRequestDismiss(_ viewController: GameViewController) {
        self.popViewController(animated: true)
    }
}
