//
//  LoginViewDelegate.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func loginView(_ view: LoginView, didLogUser user: User, in viewModel: LoginViewModel)
}
