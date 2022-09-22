//
//  StatsViewModel.swift
//  project-99
//
//  Created by Patrick on 20.09.2022..
//

import Foundation
import RealmSwift

class StatsViewModel {
    private let realm: Realm
    private let user: User
    weak var delegate: StatsViewModelDelegate?
    var isCellBottomHidden = [true, true, true]

    init(for user: User, in realm: Realm) {
        self.user = user
        self.realm = realm
    }

    func toggleCellBottom(at index: Int) {
         isCellBottomHidden[index] = !isCellBottomHidden[index]
        delegate?.statsViewModel(self, didChangeStateAtIndex: index)
    }
}
