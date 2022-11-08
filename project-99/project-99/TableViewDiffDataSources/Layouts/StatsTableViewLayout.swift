//
//  StatsTableViewLayout.swift
//  project-99
//
//  Created by Patrick on 03.11.2022..
//

import Foundation

enum StatsTableViewLayoutSections: Hashable {
    case main
}

enum StatsTableViewLayoutItems: Hashable {
    case games(StatCellModel)
    case pairs(StatCellModel)
    case gameTimes(StatCellModel)
}
