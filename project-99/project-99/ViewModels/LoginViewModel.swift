//
//  LoginViewModel.swift
//  project-99
//
//  Created by Patrick on 15.09.2022..
//

import UIKit
import RealmSwift

class LoginViewModel {
    var realm: Realm
    private var user: User = User(id: UUID(), name: "", password: "")
    private var username: String? {
        didSet {
            guard let username = username else {
                return
            }
            findUserByName(username)
        }
    }
    private var password: String?
    private var loginSuccess: Bool? {
        didSet {
            loginStatusDidChange()
        }
    }

    private var observer: ((Bool) -> Void)?

    init(in realm: Realm) {
        self.realm = realm
    }

    private func loginStatusDidChange () {
        guard let observer = observer,
        let loginSuccess = loginSuccess else {
            return
        }
        observer(loginSuccess)
    }
}

extension LoginViewModel {
    func observeLoginStatus(_ closure: @escaping ((Bool) -> Void)) {
        self.observer = closure
        loginStatusDidChange()
    }
    func usernameChanged(_ username: String) {
        self.username = username
    }

    func passwordChanged(_ password: String) {
        self.password = password
    }

    func createNewUser() {
        guard let username = username,
              let password = password else {return}
        let newUser = User(id: UUID(), name: username, password: password)

        try? realm.write {
            realm.add(newUser)
        }
    }

    func findUserByName(_ username: String) {
        if let result = realm.object(ofType: User.self, forPrimaryKey: username) {
            self.user = result
        }
    }

    func login() {
        guard let username = username,
              let password = password else {return }
        if username == user.name && password == user.password {
            print("login")
            self.loginSuccess = true
        } else {
            self.loginSuccess = false
        }
    }
}
