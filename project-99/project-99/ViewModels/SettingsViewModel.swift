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
    private var user: User
    private var newUsername: String?
    private var newPassword: String?

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

    weak var delegate: SettingsViewModelDelegate?

    init(forUser user: User, in realm: Realm) {
        self.user = user
        self.realm = realm
        loadUserSettings()
    }

    func loadUserSettings() {
        if let result = realm.object(ofType: UserSettings.self, forPrimaryKey: user.id) {
            self.userTheme = result.theme
            self.withMulticolor = result.withMulticolor
            self.withTimer = result.withTimer
        }
    }
}

private extension SettingsViewModel {
    func themeDidChange() {
        guard let themeObserver = themeObserver,
              let userTheme = userTheme else {
            return
        }
        themeObserver(userTheme)
    }

    func multicolorDidChange() {
        guard let multicolorObserver = multicolorStateObserver,
              let withMulticolor = withMulticolor else {
            return
        }
        multicolorObserver(withMulticolor)
    }

    func timerStateDidChange() {
        guard let timerStateObserver = timerStateObserver,
              let withTimer = withTimer else {
            return
        }
        timerStateObserver(withTimer)
    }
}

extension SettingsViewModel {
    // MARK: Return values

    func returnId() -> UUID {
        return user.id
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

    // MARK: Change values

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

    // MARK: Save values to Realm

    func saveTheme(save theme: ThemeChoice) {
        if let result = realm.object(ofType: UserSettings.self, forPrimaryKey: user.id) {
            try? realm.write {
                result.theme = theme
            }
        }
    }

    func saveMulticolorState(save state: Bool) {
        if let result = realm.object(ofType: UserSettings.self, forPrimaryKey: user.id) {
            try? realm.write {
                result.withMulticolor = state
            }
        }
    }

    func saveTimerState(save state: Bool) {
        if let result = realm.object(ofType: UserSettings.self, forPrimaryKey: user.id) {
            try? realm.write {
                result.withTimer = state
            }
        }
    }

    // MARK: Observe values

    func observeMulticolorState(_ closure: @escaping (Bool) -> Void) {
        self.multicolorStateObserver = closure
        multicolorDidChange()
    }

    func observerTimerState(_ closure: @escaping (Bool) -> Void) {
        self.timerStateObserver = closure
        timerStateDidChange()
    }

    // MARK: Account verification

    func verifyPassword(_ password: String) {
        if password == user.password {
            delegate?.settingsViewModel(self, didVerifyPasswordWithResult: true)
        } else {
            delegate?.settingsViewModel(self, didVerifyPasswordWithResult: false)
        }
    }

    // MARK: AlertControllers

    func addPasswordVerificationAlertController(
        in viewController: UIViewController,
        for change: AccountChanges) -> UIAlertController {
            let alertController = UIAlertController().createPasswordVerificationAlertController(
                in: viewController,
                with: self,
                for: change)
            return alertController
        }

    func addInvalidPasswordAlertController(in viewController: UIViewController) -> UIAlertController {
        let alertController = UIAlertController().createInvalidPasswordAlertController(in: viewController)
        return alertController
    }
}
