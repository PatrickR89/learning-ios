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
        for: AccountChanges) -> UIAlertController {

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

            viewModel?.verifyPassword(verificationPassword)
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
}
