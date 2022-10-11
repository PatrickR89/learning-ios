//
//  RealmDataService.swift
//  project-99
//
//  Created by Patrick on 11.10.2022..
//

import Foundation
import RealmSwift

class RealmDataService {
    private let shared = RealmDataService()
    private var realm: Realm

    init() {
        self.realm = RealmDataProvider.shared.initiateRealm()
    }
}
