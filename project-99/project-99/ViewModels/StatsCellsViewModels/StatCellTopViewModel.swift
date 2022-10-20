//
//  StatCellTopViewModel.swift
//  project-99
//
//  Created by Patrick on 22.09.2022..
//

import Foundation
import Combine

class StatCellTopViewModel {
    @Published private(set) var cellType: StatsContent
    @Published private(set) var extendedCell: Bool

    init(with cellType: StatsContent, for extendedCell: Bool) {
        self.cellType = cellType
        self.extendedCell = extendedCell
    }

    func toggleExtension(with value: Bool) {
        self.extendedCell = value
    }
}
