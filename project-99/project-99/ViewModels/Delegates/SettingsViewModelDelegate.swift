//
//  SettingsViewModelDelegate.swift
//  project-99
//
//  Created by Patrick on 19.09.2022..
//

import Foundation

protocol SettingsViewModelDelegate: AnyObject {
    func settingsViewModel(
        _ viewModel: SettingsViewModel,
        didVerifyPasswordWithResult result: Bool,
        for change: AccountOption)
}
