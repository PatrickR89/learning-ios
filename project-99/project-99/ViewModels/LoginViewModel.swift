//
//  LoginViewModel.swift
//  project-99
//
//  Created by Patrick on 15.09.2022..
//

import UIKit
import RealmSwift
import Combine

class LoginViewModel {
    private var user: User = User(id: UUID(), name: "", password: "")
    private var username: String? {
        didSet {
            guard let username = username else {
                return
            }
            if username != "" {
                findUserByName(username)
            }
        }
    }

    @Published private(set) var viewCenterYConstraint: Double = 0 {
        didSet {
            print(viewCenterYConstraint)
        }
    }

    private var password: String?

    @Published private(set) var loginSuccess: Bool?
}

extension LoginViewModel {

    func usernameChanged(_ username: String) {
        self.username = username
    }

    func passwordChanged(_ password: String) {
        self.password = password
    }

    func changeYConstraint(with value: Double) {
        self.viewCenterYConstraint = value
    }

    func createNewUser() {
        guard let username = username,
              let password = password else {return}
        if username == "" || password == "" {return}
        let newUser = User(id: UUID(), name: username, password: password)

        RealmDataService.shared.saveNewUser(newUser)

        self.loginSuccess = true
        self.user = newUser
        UserContainer.shared.setUserId(newUser.id)
    }

    func sendUser() -> User {
        return user
    }

    func findUserByName(_ username: String) {
        let result = RealmDataService.shared.findUserByName(username)

        if result.count > 0 {
            self.user = result[0]
        }
    }

    func login() {
        guard let username = username,
              let password = password else {return }
        if username == user.name && password == user.password {
            self.loginSuccess = true
            UserContainer.shared.setUserId(user.id)
            self.username = ""
            self.password = ""
        } else {
            self.loginSuccess = false
        }
    }

    func userDeleted() {
        self.user = User(id: UUID(), name: "", password: "")
        UserContainer.shared.setUserId(nil)
    }
}
