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

    private var withMulticolor: Bool? {
        didSet {
            multicolorDidChange()
            if let withMulticolor = withMulticolor {
                saveMulticolorState(save: withMulticolor)
            }
        }
    }
    
    private var withTimer: Bool?

    private var themeObserver: ((ThemeChoice) -> Void)?
    private var multicolorObserver: ((Bool) -> Void)?

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

    func returnMulticolorState() -> Bool? {
        guard let withMulticolor = withMulticolor else {
            return nil
        }
        return withMulticolor
    }

    func saveTheme(save theme: ThemeChoice) {
        if let result = realm.object(ofType: UserSettings.self, forPrimaryKey: userId) {
            try? realm.write {
                result.theme = theme
            }
        }
    }

    func saveMulticolorState(save state: Bool) {
        if let result = realm.object(ofType: UserSettings.self, forPrimaryKey: userId) {
            try? realm.write {
                result.withMulticolor = state
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

    func changeMulticolor() {
        guard let withMulticolor = withMulticolor else {
            return
        }
        self.withMulticolor = !withMulticolor
    }

    private func themeDidChange() {
        guard let themeObserver = themeObserver,
              let userTheme = userTheme else {
            return
        }
        themeObserver(userTheme)
    }

    private func multicolorDidChange() {
        guard let multicolorObserver = multicolorObserver,
              let withMulticolor = withMulticolor else {
            return
        }
        multicolorObserver(withMulticolor)
    }

    func observeMulticolorState(_ closure: @escaping (Bool) -> Void) {
        self.multicolorObserver = closure
        multicolorDidChange()
    }

    func loadUserSettings() {
        if let result = realm.object(ofType: UserSettings.self, forPrimaryKey: userId) {
            self.userTheme = result.theme
            self.withMulticolor = result.withMulticolor
            self.withTimer = result.withTimer
        }
    }
}
