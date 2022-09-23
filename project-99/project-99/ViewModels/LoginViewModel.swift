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
            if username != "" {
                findUserByName(username)
            }
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

        let newSettings = UserSettings(
            userId: newUser.id,
            theme: .system,
            withMulticolor: false,
            withTimer: false)

        let newStats = UserGamesStats(
            userId: newUser.id,
            numberOfGames: 0,
            numOfGamesWon: 0,
            cardsClicked: 0,
            pairsRevealed: 0,
            totalPlayTime: 0.0)

        let initialTimes = LevelTimes(
            userId: newUser.id,
            veryEasy: 0.0,
            easy: 0.0,
            mediumHard: 0.0,
            hard: 0.0,
            veryHard: 0.0,
            emotionalDamage: 0.0)

        try? realm.write {
            realm.add(newUser)
            realm.add(newSettings)
            realm.add(newStats)
            realm.add(initialTimes)
        }

        self.loginSuccess = true
        self.user = newUser
        UserContainer.shared.saveUser(with: newUser.id)
    }

    func sendUser() -> User {
        return user
    }

    func findUserByName(_ username: String) {
        let result = realm.objects(User.self).where {
            $0.name == username
        }

        if result.count > 0 {
            self.user = result[0]
        }
    }

    func login() {
        guard let username = username,
              let password = password else {return }
        if username == user.name && password == user.password {
            self.loginSuccess = true
            UserContainer.shared.saveUser(with: user.id)
            self.username = ""
            self.password = ""
        } else {
            self.loginSuccess = false
        }
    }
}
