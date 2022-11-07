//
//  SettingsViewModelActions.swift
//  project-99
//
//  Created by Patrick on 04.11.2022..
//

import Foundation

protocol SettingsViewModelActions: AnyObject {
    func viewModelDidRecieveAccountDeletion(_ viewModel: SettingsViewModel)
    func viewModel(_ viewModel: SettingsViewModel, didChangeUsernameWith username: String)
}
