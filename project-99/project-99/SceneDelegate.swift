//
//  SceneDelegate.swift
//  project-99
//
//  Created by Patrick on 15.09.2022..
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let navController = UINavigationController()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene: UIWindowScene = (scene as? UIWindowScene) else {return}
        setupLoginViewController()

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }

    func setupLoginViewController() {
        let loginViewController = LoginViewController()
        loginViewController.delegate = self
        navController.setViewControllers([loginViewController], animated: true)
    }
}

extension SceneDelegate: LoginViewControllerDelegate {
    func loginViewController(
        _ viewController: LoginViewController,
        didLogUserInViewModel viewModel: MainMenuViewModel) {

            let mainMenuViewController = MainMenuViewController(with: viewModel)
            mainMenuViewController.delegate = self
            navController.setViewControllers([mainMenuViewController], animated: true)
        }
}

extension SceneDelegate: MainMenuViewControllerDelegate {
    func mainMenuViewControllerDidOpenNewGame(_ viewController: MainMenuViewController) {
        let viewController = NewGameViewController()
        viewController.delegate = self
        navController.pushViewController(viewController, animated: true)
    }

    func mainMenuViewController(
        _ viewController: MainMenuViewController,
        didReciveAccountDeletionFrom settingsViewController: SettingsViewController) {
            RealmDataService.shared.deleteAccount()
            UserContainer.shared.setUserId(nil)
            setupLoginViewController()
        }

    func mainMenuViewControllerDidRecieveLogout(_ viewController: MainMenuViewController) {
        UserContainer.shared.setUserId(nil)
        setupLoginViewController()
    }
}

extension SceneDelegate: NewGameViewControllerDelegate {
    func newGameViewController(
        _ viewController: NewGameViewController,
        didStartNewGameWithViewModel viewModel: GameVCViewModel,
        and stopwatch: Stopwatch) {

            let viewController = GameViewController(with: viewModel, and: stopwatch)
            viewController.delegate = self
            navController.pushViewController(viewController, animated: true)
        }

    func newGameViewControllerDidRequestDismiss(_ viewController: NewGameViewController) {
        navController.popViewController(animated: true)
    }
}

extension SceneDelegate: GameViewControllerDelegate {
    func gameViewControllerDidRequestDismiss(_ viewController: GameViewController) {
        navController.popViewController(animated: true)
    }
}
