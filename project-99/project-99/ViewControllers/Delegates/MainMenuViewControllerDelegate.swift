//
//  MainMenuViewControllerDelegate.swift
//  project-99
//
//  Created by Patrick on 14.10.2022..
//

import Foundation

protocol MainMenuViewControllerDelegate: AnyObject {
    func mainMenuViewController(_ viewController: MainMenuViewController,
                                didReciveAccountDeletionFrom settingsViewController: SettingsViewController)
    func mainMenuViewControllerDidRecieveLogout(_ viewController: MainMenuViewController)
}
