//
//  MainMenuViewModel.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import Foundation
import RealmSwift

class MainMenuViewModel {
    private let realm: Realm
    private let user: User

    init(for user: User, in realm: Realm) {
        self.user = user
        self.realm = realm
    }
}

extension MainMenuViewModel {
    func setUsername() -> String {
        return user.name
    }

    func returnUserId() -> UUID {
        return user.id
    }
}
