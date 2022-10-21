//
//  UIAlertController+Extensions.swift
//  project-99
//
//  Created by Patrick on 19.09.2022..
//

import UIKit

extension UIAlertController {
    func createPasswordVerificationAlertController(
        in viewController: UIViewController,
        with viewModel: SettingsViewModel,
        forChangeInAccount change: AccountChanges) -> UIAlertController {

            let alertController = UIAlertController(
                title: "Enter your password",
                message: "In order to make changes, please enter your current password",
                preferredStyle: .alert)

            alertController.addTextField()
            alertController.textFields?[0].isSecureTextEntry = true

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

            let proceedAction = UIAlertAction(
                title: "Proceed",
                style: .default) {  [weak viewModel, weak alertController, weak self] _ in
                    guard let verificationPassword = alertController?.textFields?[0].text else {return}

                    viewModel?.verifyPassword(verificationPassword, for: change)
                    self?.dismiss(animated: true)
                }
            alertController.addAction(cancelAction)
            alertController.addAction(proceedAction)

            return alertController
        }

    func createInvalidPasswordAlertController(in viewController: UIViewController) -> UIAlertController {
        let alertController = UIAlertController(title: "Invalid password", message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)

        alertController.addAction(alertAction)
        return alertController
    }

    func createEditAccountAlertController(
        in viewController: UIViewController,
        with viewModel: SettingsViewModel,
        for change: AccountChanges) -> UIAlertController {
            var title: String
            var changeActionTitle: String
            var changeActionStyle: UIAlertAction.Style
            switch change {
            case .username:
                title = "Enter new username"
                changeActionTitle = "Change"
                changeActionStyle = .default
            case .password:
                title = "Enter new password"
                changeActionTitle = "Change"
                changeActionStyle = .default
            case .delete:
                title = "Delete account?"
                changeActionTitle = "Delete"
                changeActionStyle = .destructive
            }
            let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            if change != .delete {
                alertController.addTextField()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let changeAction = UIAlertAction(
                title: changeActionTitle,
                style: changeActionStyle) { [weak viewModel, weak alertController] _ in

                    switch change {
                    case .username:
                        guard let input = alertController?.textFields?[0].text else {return}
                        viewModel?.userDidEditUsername(with: input)
                    case .password:
                        guard let input = alertController?.textFields?[0].text else {return}
                        viewModel?.userDidEditPassword(with: input)
                    case .delete:
                        viewModel?.userDidDeleteAccount()
                    }
                }

            alertController.addAction(cancelAction)
            alertController.addAction(changeAction)

            return alertController
        }

    func createGameOverAlertController(
        in viewController: GameViewController,
        with viewModel: GameVCViewModel) -> UIAlertController {

            let alertController = UIAlertController(
                title: "Game Over",
                message: nil,
                preferredStyle: .alert)

            let alertAction = UIAlertAction(
                title: "Ok",
                style: .default) { [weak viewController] _ in
                    viewController?.dismiss(animated: true)
                }
            alertController.addAction(alertAction)

            return alertController
        }

    func createGameWonAlertController(
        in viewController: GameViewController,
        with viewModel: GameVCViewModel) -> UIAlertController {

            let alertController = UIAlertController(
                title: "You win!",
                message: nil,
                preferredStyle: .alert)

            let alertAction = UIAlertAction(
                title: "Ok",
                style: .default) { [weak viewController] _ in
                    viewController?.dismiss(animated: true)
                }
            alertController.addAction(alertAction)

            return alertController
        }
}
