//
//  LoginViewModel.swift
//  project-99
//
//  Created by Patrick on 15.09.2022..
//

import UIKit

class LoginViewModel {
    private var user: User = User(id: UUID(), name: "", password: "")
    private var username: String? {
        didSet {
            guard let username = username else {
                return
            }
            print(username)
        }
    }
    private var password: String?

}

extension LoginViewModel {
    func usernameChanged(_ username: String) {
        self.username = username
    }

    func passwordChanged(_ password: String) {
        self.password = password
    }
}
