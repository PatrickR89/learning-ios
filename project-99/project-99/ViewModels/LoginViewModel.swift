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

    @Published private(set) var viewCenterYConstraint: Double = 0

    private var password: String?

    @Published private(set) var loginSuccess: Bool?

    weak var delegate: LoginViewModelDelegate?
    weak var actions: LoginViewModelActions?

    private var isLoggedIn: AnyCancellable?

    init() {
        setupBindings()
    }

    deinit {
        isLoggedIn?.cancel()
    }
}

extension LoginViewModel: PasswordHash {
    func createNewUser() -> Bool {
        guard let username = username,
              let password = password else {return false}
        if username == "" || password == "" {return false}
        let newId = UUID()
        let newPassword = hashPassword(password: password, salt: newId)
        let newUser = User(id: newId, name: username, password: newPassword)

        let response = RealmDataService.shared.saveNewUser(newUser)

        if response {
            self.loginSuccess = true
            self.user = newUser
            UserContainer.shared.setUserId(newUser.id)
            return true
        } else {
            delegate?.viewModelDidFailAccountCreation(self)
            return false
        }
    }

    func login() {
        guard let username = username,
              let password = password else {return }
        let hashedPassword = hashPassword(password: password, salt: user.id)
        if username == user.name && hashedPassword == user.password {
            self.loginSuccess = true
            UserContainer.shared.setUserId(user.id)
            self.username = ""
            self.password = ""
        } else {
            self.loginSuccess = false
        }
    }
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

    func findUserByName(_ username: String) {
        let result = RealmDataService.shared.findUserByName(username)

        if result.count > 0 {
            self.user = result[0]
        }
    }

    func userDeleted() {
        self.user = User(id: UUID(), name: "", password: "")
        UserContainer.shared.setUserId(nil)
    }

    func setupBindings() {

        isLoggedIn = self.$loginSuccess
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] loginStatus in
                guard let self = self,
                      let loginStatus = loginStatus  else {return}
                if !loginStatus {
                    self.delegate?.viewModelDidFailLogin(self)
                } else {
                    self.actions?.viewModel(self, didLogUser: self.user)
                }
            })
    }
}
