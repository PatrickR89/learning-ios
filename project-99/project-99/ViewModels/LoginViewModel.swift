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
    private var user: User = User(id: UUID(), name: "", password: "") {
        didSet {
            print(user)
        }
    }
    private var username: String? {
        didSet {
            guard let username = username else {
                return
            }
            findUserByName(username)
        }
    }
    private var password: String?

    init(in realm: Realm) {
        self.realm = realm
    }

}

extension LoginViewModel {
    func usernameChanged(_ username: String) {
        self.username = username
        print(username)
    }

    func passwordChanged(_ password: String) {
        self.password = password
        print(password)
    }

    func createNewUser() {
        print("saving")
        guard let username = username,
              let password = password else {return}
        print("saved")
        let newUser = User(id: UUID(), name: username, password: password)

        try? realm.write {
            realm.add(newUser)
        }
    }

    func findUserByName(_ username: String) {
        print("searching")
        print(realm.objects(User.self))
        if let result = realm.object(ofType: User.self, forPrimaryKey: username) {
            self.user = result
        }
    }
}
