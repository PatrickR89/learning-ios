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
    private var userTheme: ThemeChoice? {
        didSet {
            themeDidChange()
            if let userTheme = userTheme {
                ThemeContainer.shared.changeTheme(to: userTheme)
                saveTheme(save: userTheme)
            }
        }
    }

    private var withMulticolor: Bool?
    private var withTimer: Bool?

    private var themeObserver: ((ThemeChoice) -> Void)?

    init(forUser userId: UUID, in realm: Realm) {
        self.userId = userId
        self.realm = realm
        loadUserSettings()
    }

    func returnId() -> UUID {
        return userId
    }

    func returnTheme() -> ThemeChoice? {
        guard let theme = userTheme else {return nil}
        return theme
    }

    func saveTheme(save theme: ThemeChoice) {
        if let result = realm.object(ofType: UserSettings.self, forPrimaryKey: userId) {
            try? realm.write {
                result.theme = theme
            }
        }
    }

    func changeTheme() {
        let themes: [ThemeChoice] = [.system, .dark, .light]
        if let index = themes.firstIndex(where: {$0.rawValue == userTheme?.rawValue}) {
            var newIndex = index + 1
            if newIndex > themes.count - 1 {
                newIndex = 0
            }
            userTheme = themes[newIndex]
        }
    }

    private func themeDidChange() {
        guard let themeObserver = themeObserver,
              let userTheme = userTheme else {
            return
        }
        themeObserver(userTheme)
    }

    func loadUserSettings() {
        if let result = realm.object(ofType: UserSettings.self, forPrimaryKey: userId) {
            self.userTheme = result.theme
            self.withMulticolor = result.withMulticolor
            self.withTimer = result.withTimer
        }
    }
}
