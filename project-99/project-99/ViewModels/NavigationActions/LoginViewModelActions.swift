//
//  LoginViewModelActions.swift
//  project-99
//
//  Created by Patrick on 07.11.2022..
//

import Foundation

protocol LoginViewModelActions: AnyObject {
    func viewModel(_ viewModel: LoginViewModel, didLogUser user: User)
}
