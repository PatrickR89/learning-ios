//
//  MenuCoordinator.swift
//  project-99
//
//  Created by Patrick on 04.11.2022..
//

import UIKit

class MenuCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: MainCoordinator?
    var navController: UINavigationController

    init(navController: UINavigationController) {
        self.navController = navController
    }

    func startAsChild(user: User) {
        let viewModel = MainMenuViewModel(for: user)
        let viewController = MainMenuViewController(with: viewModel)
        viewController.coordinator = self
        viewModel.action = self
        navController.setViewControllers([viewController], animated: true)
    }

    private func returnToRootView() {
        UserContainer.shared.setUserId(nil)
        parentCoordinator?.start(animated: true)
    }
}

extension MenuCoordinator: MainMenuViewModelDelegate {
    func viewModel(_ viewModel: MainMenuViewModel, didOpenStatsFor user: User) {
        let viewModel = StatsViewModel(for: user)
        let viewController = StatsViewController(with: viewModel)
        let tempNav = UINavigationController()
        tempNav.viewControllers = [viewController]
        navController.present(tempNav, animated: true)
    }

    func viewModel(_ viewModel: MainMenuViewModel, didOpenSettingsFor user: User) {
        let viewModel = SettingsViewModel(forUser: user)
        viewModel.action = self
        let viewController = SettingsViewController(with: viewModel)
        let tempNav = UINavigationController()

        tempNav.viewControllers = [viewController]
        navController.present(tempNav, animated: true)
    }

    func viewModelDidOpenNewGame(_ viewModel: MainMenuViewModel) {
        let gameViewModel = NewGameViewModel()
        gameViewModel.delegate = self
        let viewController = NewGameViewController(with: gameViewModel)
        navController.pushViewController(viewController, animated: true)
    }

    func viewModelDidLogOut(_ viewModel: MainMenuViewModel) {
        returnToRootView()
    }
}

extension MenuCoordinator: SettingsViewModelActions {

    func viewModel(_ viewModel: SettingsViewModel, didChangeUsernameWith username: String) {
        guard let viewController = navController.viewControllers[0] as? MainMenuViewController else {return}
        viewController.changeTitle(with: username)
    }

    func viewModelDidRecieveAccountDeletion(_ viewModel: SettingsViewModel) {
        RealmDataService.shared.deleteAccount()
        UserContainer.shared.setUserId(nil)
        if let tempNav = navController.presentedViewController as? UINavigationController {
            tempNav.dismiss(animated: true)
        }
        returnToRootView()
    }
}

extension MenuCoordinator: NewGameViewModelDelegate {
    func newGameViewModelDidRequestDismiss(_ viewModel: NewGameViewModel) {
        navController.popViewController(animated: true)
    }

    func newGameViewModel(_ viewModel: NewGameViewModel, didStartNewLevel level: Level) {
        let stopwatch = StopwatchTimer()
        let viewModel = GameVCViewModel(for: level, with: stopwatch)

        let viewController = GameViewController(with: viewModel, and: stopwatch)
        viewController.delegate = self
        navController.pushViewController(viewController, animated: true)
    }
}

extension MenuCoordinator: GameViewControllerDelegate {
    func gameViewControllerDidRequestDismiss(_ viewController: GameViewController) {
        navController.popViewController(animated: true)
    }
}
