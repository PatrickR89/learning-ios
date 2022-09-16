//
//  MainMenuViewModel.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import Foundation

class MainMenuViewModel {
    private let user: User

    init(for user: User) {
        self.user = user
    }
}

extension MainMenuViewModel {
    func setUsername() -> String {
        return user.name
    }
}
