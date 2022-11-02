//
//  UserContainer.swift
//  project-99
//
//  Created by Patrick on 21.09.2022..
//

import UIKit
import Combine

class UserContainer {
    static let shared = UserContainer()

    @Published private(set) var userId: UUID?

    func setUserId(_ id: UUID?) {
        guard let id = id else {
            return
        }

        self.userId = id
    }
}
