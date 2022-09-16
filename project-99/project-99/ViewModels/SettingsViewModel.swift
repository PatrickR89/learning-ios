//
//  SettingsViewModel.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import Foundation
import RealmSwift

class SettingsViewModel {
    private var userId: UUID

    init(forUser userId: UUID) {
        self.userId = userId
    }

    func returnId() -> UUID {
        return userId
    }
}
