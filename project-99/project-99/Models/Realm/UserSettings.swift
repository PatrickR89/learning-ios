//
//  UserSettings.swift
//  project-99
//
//  Created by Patrick on 15.09.2022..
//

import UIKit
import RealmSwift

class UserSettings: Object {
    @Persisted (primaryKey: true) var userId: UUID
    @Persisted var theme: ThemeChoice
    @Persisted var withMulticolor: Bool
    @Persisted var withTimer: Bool

    convenience init(userId: UUID, theme: ThemeChoice, withMulticolor: Bool, withTimer: Bool) {
        self.init()
        self.userId = userId
        self.theme = theme
        self.withMulticolor = withMulticolor
        self.withTimer = withTimer
    }
}
