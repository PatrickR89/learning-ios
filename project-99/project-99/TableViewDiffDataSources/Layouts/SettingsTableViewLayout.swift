//
//  SettingsTableViewLayout.swift
//  project-99
//
//  Created by Patrick on 31.10.2022..
//

import Foundation

enum SettingsTableViewLayoutSections: Hashable {
    case gameSettings
    case accountSettings
}

enum SettingsTableViewLayoutItems: Hashable {
    case theme(ThemeTableCellModel)
    case gameOption(GameOptionCellModel)
    case accountOption(AccountOptionCellModel)
}
