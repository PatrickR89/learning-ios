//
//  SettingsViewModel.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import UIKit
import Combine

class SettingsViewModel {
    private var user: User

    @Published private(set) var newUsername: String? {
        didSet {
            guard let newUsername = newUsername else {
                return
            }
            RealmDataService.shared.changeUsername(newUsername)
        }
    }

    private var newPassword: String? {
        didSet {
            guard let newPassword = newPassword else {
                return
            }
            RealmDataService.shared.changePassword(newPassword)
        }
    }

    @Published private(set) var userTheme: ThemeChoice? {
        didSet {
            if let userTheme = userTheme {
                ThemeContainer.shared.changeTheme(to: userTheme)
            }
        }
    }

    @Published private(set) var withMulticolor: Bool?

    @Published private(set) var withTimer: Bool?

    weak var delegate: SettingsViewModelDelegate?

    init(forUser user: User) {
        self.user = user
        loadUserSettings()
    }

    func saveSettings() {
        if let withTimer = withTimer {
            RealmDataService.shared.saveTimerState(withTimer)
        }
        if let withMulticolor = withMulticolor {
            RealmDataService.shared.saveMulticolorState(withMulticolor)
        }
        if let userTheme = userTheme {
            RealmDataService.shared.saveTheme(userTheme)
        }
    }

    func loadUserSettings() {
        guard let result = RealmDataService.shared.loadUserSettingsById(user.id) else {return}
        self.userTheme = result.theme
        self.withMulticolor = result.withMulticolor
        self.withTimer = result.withTimer
    }

    func populateTableView(_ isInitial: Bool, in viewController: SettingsViewController) {
        let theme = SettingsTableViewLayoutItems.theme(ThemeTableCellModel(with: self))
        let multicolor = SettingsTableViewLayoutItems.gameOption(GameOptionCellModel(with: .multicolor, and: self))
        let timer = SettingsTableViewLayoutItems.gameOption(GameOptionCellModel(with: .timer, and: self))
        let username = SettingsTableViewLayoutItems.accountOption(AccountOptionCellModel(AccountOption.username))
        let password = SettingsTableViewLayoutItems.accountOption(AccountOptionCellModel(AccountOption.password))
        let delete = SettingsTableViewLayoutItems.accountOption(AccountOptionCellModel(AccountOption.delete))

        let gameOptions: [SettingsTableViewLayoutItems] = [theme, multicolor, timer]
        let userOptions: [SettingsTableViewLayoutItems] = [username, password, delete]

        var snapshot = NSDiffableDataSourceSnapshot<SettingsTableViewLayoutSections, SettingsTableViewLayoutItems>()
        snapshot.appendSections([.gameSettings, .accountSettings])
        snapshot.appendItems(gameOptions, toSection: .gameSettings)
        snapshot.appendItems(userOptions, toSection: .accountSettings)

        if isInitial {
            viewController.tableViewDataSource.apply(snapshot)
        } else {
            viewController.tableViewDataSource.defaultRowAnimation = .fade
            viewController.tableViewDataSource.apply(snapshot, animatingDifferences: true)
        }

    }
}

extension SettingsViewModel {
    // MARK: Return values

    func provideUserTheme() -> ThemeChoice? {
        guard let theme = userTheme else {return nil}
        return theme
    }

    func provideUserMulticolorState() -> Bool? {
        guard let withMulticolor = withMulticolor else {
            return nil
        }
        return withMulticolor
    }

    func provideUserTimerState() -> Bool? {
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

    func userDidDeleteAccount() {
        delegate?.settingsViewModelDidDeleteAccount(self)
    }

    // MARK: Account verification

    func verifyPassword(_ password: String, for change: AccountOption) {
        if password == user.password {
            delegate?.settingsViewModel(self, didVerifyPasswordWithResult: true, for: change)
        } else {
            delegate?.settingsViewModel(self, didVerifyPasswordWithResult: false, for: change)
        }
    }

    // MARK: AlertControllers

    func addPasswordVerificationAlertController(
        for option: AccountOption) -> UIAlertController {
            let alertController = UIAlertController().createPasswordVerificationAlertController(
                self,
                forChangeInAccount: option)
            return alertController
        }

    func addInvalidPasswordAlertController() -> UIAlertController {
        let alertController = UIAlertController().createInvalidPasswordAlertController()
        return alertController
    }

    func addChangeAccountAlertController(
        in viewController: UIViewController,
        for change: AccountOption) -> UIAlertController {
            let alertController = UIAlertController().createEditAccountAlertController(
                self,
                for: change)
            return alertController
        }
}
