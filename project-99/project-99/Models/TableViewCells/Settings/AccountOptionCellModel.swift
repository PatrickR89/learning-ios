//
//  AccountOptionCellModel.swift
//  project-99
//
//  Created by Patrick on 31.10.2022..
//

import Foundation

struct AccountOptionCellModel: Hashable {
    var type: AccountOption
    var title: String
    var destructive: Bool

    init(_ type: AccountOption) {
        self.type = type
        switch type {
        case .username:
            self.title = "Change username"
            self.destructive = false
        case .password:
            self.title = "Change password"
            self.destructive = false
        case .delete:
            self.title = "Delete account"
            self.destructive = true
        }
    }
}
