//
//  RealmDataService.swift
//  challenge-d90-withMVVM-framework
//
//  Created by Patrick on 07.09.2022..
//

import UIKit
import RealmSwift

class RealmDataService {
    static let shared = RealmDataService()

    func initiateRealm() -> Realm {
        guard let realm = try? Realm(configuration: Realm.Configuration.defaultConfiguration) else {fatalError()}
        return realm
    }
}
