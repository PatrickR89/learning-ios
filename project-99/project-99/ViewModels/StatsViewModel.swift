//
//  StatsViewModel.swift
//  project-99
//
//  Created by Patrick on 20.09.2022..
//

import Foundation
import RealmSwift

class StatsViewModel {
    private let realm: Realm
    private let user: User

    init(for user: User, in realm: Realm) {
        self.user = user
        self.realm = realm
    }
}
