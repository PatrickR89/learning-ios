//
//  SettingsViewControllerDelegate.swift
//  project-99
//
//  Created by Patrick on 19.09.2022..
//

import Foundation

protocol SettingsViewControllerDelegate: AnyObject {
    func settingsViewController(
        _ viewController: SettingsViewController,
        didRecieveUpdatedName username: String)
    func settingsViewController(
        _ viewController: SettingsViewController,
        didReciveAccountDeletionFrom viewModel: SettingsViewModel)
}
