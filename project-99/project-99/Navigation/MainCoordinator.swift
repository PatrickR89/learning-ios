//
//  MainCoordinator.swift
//  project-99
//
//  Created by Patrick on 04.11.2022..
//

import UIKit

class MainCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    var navController: UINavigationController

    init(_ navController: UINavigationController) {
        self.navController = navController

    }

    func start(animated: Bool) {
        let viewController = LoginViewController()
        viewController.viewModel.actions = self
        navController.delegate = self
        navController.setViewControllers([viewController], animated: animated)
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            } else {return}
        }
    }
}

extension MainCoordinator: LoginViewModelActions {
    func viewModel(_ viewModel: LoginViewModel, didLogUser user: User) {
        let menuCoordinator = MenuCoordinator(navController: navController)
        childCoordinators.append(menuCoordinator)
        menuCoordinator.parentCoordinator = self
        menuCoordinator.startAsChild(user: user)
    }
}

extension MainCoordinator: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool) {
        guard let fromViewController = navigationController
            .transitionCoordinator?
            .viewController(forKey: .from) else {return}
        if navigationController.viewControllers.contains(fromViewController) {return}
        if let menuViewController = fromViewController as? MainMenuViewController {
            childDidFinish(menuViewController.coordinator)
        }
    }
}
