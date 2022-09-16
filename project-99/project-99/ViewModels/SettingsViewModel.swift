//
//  SettingsViewModel.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import Foundation
import RealmSwift

class SettingsViewModel {
    private let realm: Realm
    private var userId: UUID
    private var userTheme: Theme? {
        didSet {
            themeDidChange()
        }
    }

    private var withMulticolor: Bool?
    private var withTimer: Bool?

    private var themeObserver: ((Theme) -> Void)?

    init(forUser userId: UUID, in realm: Realm) {
        self.userId = userId
        self.realm = realm
        loadUserSettings()
    }

    func returnId() -> UUID {
        return userId
    }

    func observeTheme(_ closure: @escaping ((Theme) -> Void)) {
        self.themeObserver = closure
        themeDidChange()
    }

    func returnTheme() -> Theme? {
        guard let theme = userTheme else {return nil}
        return theme
    }

    private func themeDidChange() {
        guard let themeObserver = themeObserver,
        let userTheme = userTheme else {
            return
        }
        themeObserver(userTheme)
    }

    private func loadUserSettings() {
        if let result = realm.object(ofType: UserSettings.self, forPrimaryKey: userId) {
            self.userTheme = result.theme
            self.withMulticolor = result.withMulticolor
            self.withTimer = result.withTimer
        }
    }
}
