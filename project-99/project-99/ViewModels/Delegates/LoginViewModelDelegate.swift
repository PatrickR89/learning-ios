//
//  LoginViewModelDelegate.swift
//  project-99
//
//  Created by Patrick on 07.11.2022..
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func viewModelDidFailLogin(_ viewModel: LoginViewModel)
    func viewModelDidFailAccountCreation(_ viewModel: LoginViewModel)
}
