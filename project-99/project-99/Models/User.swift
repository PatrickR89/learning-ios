//
//  User.swift
//  project-99
//
//  Created by Patrick on 15.09.2022..
//

import UIKit
import RealmSwift

class User: Object {
    @Persisted var id: UUID
    @Persisted (primaryKey: true) var name: String
    @Persisted var password: String

    convenience init(id: UUID, name: String, password: String) {
        self.init()
        self.id = id
        self.name = name
        self.password = password
    }
}
