//
//  StatsViewModel.swift
//  project-99
//
//  Created by Patrick on 20.09.2022..
//

import Foundation

class StatsViewModel {
    private let user: User
    weak var delegate: StatsViewModelDelegate?
    var isCellBottomHidden = [true, true, true]

    init(for user: User) {
        self.user = user
    }

    func toggleCellBottom(at index: Int) {
        isCellBottomHidden[index] = !isCellBottomHidden[index]
        delegate?.statsViewModel(self, didChangeStateAtIndex: index, withState: isCellBottomHidden[index])
    }

    func hideAllCellBottoms() {
        for (index, _) in isCellBottomHidden.enumerated() {
            isCellBottomHidden[index] = true
            delegate?.statsViewModel(self, didChangeStateAtIndex: index, withState: isCellBottomHidden[index])
        }
    }
}
