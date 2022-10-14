//
//  SettingsViewModel.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import Foundation
import RealmSwift

class SettingsViewModel {
    private var user: User
    private var newUsername: String? {
        didSet {
            guard let newUsername = newUsername else {
                return
            }
            RealmDataService.shared.changeUsername(with: newUsername)
            delegate?.settingsViewModel(self, didChangeUsername: newUsername)
        }
    }
    private var newPassword: String? {
        didSet {
            guard let newPassword = newPassword else {
                return
            }
            RealmDataService.shared.changePassword(with: newPassword)
        }
    }

    private var userTheme: ThemeChoice? {
        didSet {
            themeDidChange()
            if let userTheme = userTheme {
                ThemeContainer.shared.changeTheme(to: userTheme)
                RealmDataService.shared.saveTheme(save: userTheme)
            }
        }
    }

    private var withMulticolor: Bool? {
        didSet {
            multicolorDidChange()
            if let withMulticolor = withMulticolor {
                RealmDataService.shared.saveMulticolorState(save: withMulticolor)
            }
        }
    }

    private var withTimer: Bool? {
        didSet {
            timerStateDidChange()
            if let withTimer = withTimer {
                RealmDataService.shared.saveTimerState(save: withTimer)
            }
        }
    }

    private var themeObserver: ((ThemeChoice) -> Void)?
    private var multicolorStateObserver: ((Bool) -> Void)?
    private var timerStateObserver: ((Bool) -> Void)?

    weak var delegate: SettingsViewModelDelegate?

    init(forUser user: User) {
        self.user = user
        loadUserSettings()
    }

    func loadUserSettings() {
        let result = RealmDataService.shared.loadUserSettings(forUser: user.id)
            self.userTheme = result.theme
            self.withMulticolor = result.withMulticolor
            self.withTimer = result.withTimer

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

    func toggleMulticolor() {
        guard let withMulticolor = withMulticolor else {
            return
        }
        self.withMulticolor = !withMulticolor
    }

    func toggleTimer() {
        guard let withTimer = withTimer else {
            return
        }
        self.withTimer = !withTimer
    }

    func userDidEditUsername(with name: String) {
        self.newUsername = name
    }

    func userDidEditPassword(with password: String) {
        self.newPassword = password
    }

    func deleteAccount() {
        delegate?.settingsViewModelDidDeleteAccount(self)
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

    func observeThemeState(_ closure: @escaping(ThemeChoice) -> Void) {
        self.themeObserver = closure
        themeDidChange()
    }

    // MARK: Account verification

    func verifyPassword(_ password: String, for change: AccountChanges) {
        if password == user.password {
            delegate?.settingsViewModel(self, didVerifyPasswordWithResult: true, for: change)
        } else {
            delegate?.settingsViewModel(self, didVerifyPasswordWithResult: false, for: change)
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

    func addChangeAccountAlertController(
        in viewController: UIViewController,
        for change: AccountChanges) -> UIAlertController {
            let alertController = UIAlertController().editAccountAlertController(
                in: viewController,
                with: self,
                for: change)
            return alertController
        }
}
