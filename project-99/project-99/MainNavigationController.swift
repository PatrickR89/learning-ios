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
