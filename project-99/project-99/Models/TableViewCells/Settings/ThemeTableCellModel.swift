//
//  ThemeTableViewCellModel.swift
//  project-99
//
//  Created by Patrick on 31.10.2022..
//

import Foundation

struct ThemeTableCellModel: Hashable {
    var title: String
    var value: ThemeChoice

    init(with viewModel: SettingsViewModel) {
        self.title = "Theme:"
        if let theme = viewModel.provideUserTheme() {
            self.value = theme
        } else {
            self.value = .system
        }
    }
}
