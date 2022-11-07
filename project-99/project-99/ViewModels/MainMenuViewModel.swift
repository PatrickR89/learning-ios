//
//  MainMenuViewModel.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import Foundation

class MainMenuViewModel {
    private let user: User
    weak var action: MainMenuViewModelActions?

    init(for user: User) {
        self.user = user
    }
}

extension MainMenuViewModel {
    func setUsername() -> String {
        return user.name
    }

    func openSettings() {
        action?.viewModel(self, didOpenSettingsFor: user)
    }

    func openStats() {
        action?.viewModel(self, didOpenStatsFor: user)
    }

    func openNewGame() {
        action?.viewModelDidOpenNewGame(self)
    }

    func logout() {
        action?.viewModelDidLogOut(self)
    }
}
