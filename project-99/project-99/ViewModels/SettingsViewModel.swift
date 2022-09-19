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

    private var withTimer: Bool? {
        didSet {
            timerStateDidChange()
            if let withTimer = withTimer {
                saveTimerState(save: withTimer)
            }
        }
    }

    private var themeObserver: ((ThemeChoice) -> Void)?
    private var multicolorStateObserver: ((Bool) -> Void)?
    private var timerStateObserver: ((Bool) -> Void)?

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

    func returnTimerState() -> Bool? {
        guard let withTimer = withTimer else {
            return nil
        }
        return withTimer
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

    func saveTimerState(save state: Bool) {
        if let result = realm.object(ofType: UserSettings.self, forPrimaryKey: userId) {
            try? realm.write {
                result.withTimer = state
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

    func changeTimer() {
        guard let withTimer = withTimer else {
            return
        }
        self.withTimer = !withTimer
    }

    private func themeDidChange() {
        guard let themeObserver = themeObserver,
              let userTheme = userTheme else {
            return
        }
        themeObserver(userTheme)
    }

    private func multicolorDidChange() {
        guard let multicolorObserver = multicolorStateObserver,
              let withMulticolor = withMulticolor else {
            return
        }
        multicolorObserver(withMulticolor)
    }

    private func timerStateDidChange() {
        guard let timerStateObserver = timerStateObserver,
              let withTimer = withTimer else {
            return
        }
        timerStateObserver(withTimer)
    }

    func observeMulticolorState(_ closure: @escaping (Bool) -> Void) {
        self.multicolorStateObserver = closure
        multicolorDidChange()
    }

    func observerTimerState(_ closure: @escaping (Bool) -> Void) {
        self.timerStateObserver = closure
        timerStateDidChange()
    }

    func loadUserSettings() {
        if let result = realm.object(ofType: UserSettings.self, forPrimaryKey: userId) {
            self.userTheme = result.theme
            self.withMulticolor = result.withMulticolor
            self.withTimer = result.withTimer
        }
    }
}
