//
//  LoginViewControllerDelegate.swift
//  project-99
//
//  Created by Patrick on 27.10.2022..
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    func loginViewController(_ viewController: LoginViewController, didLogUserInViewModel viewModel: MainMenuViewModel)
}
