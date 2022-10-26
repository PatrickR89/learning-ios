//
//  GridLayout.swift
//  project-99
//
//  Created by Patrick on 24.10.2022..
//

import Foundation

struct GridLayout {
    var level: Level
    var columns: Int
    var rows: Int

    init(_ level: Level) {
        self.level = level
        switch level {
        case .veryEasy:
            self.columns = 2
            self.rows = 4
        case .easy:
            self.columns = 3
            self.rows = 4
        case .mediumHard:
            self.columns = 4
            self.rows = 4
        case .hard:
            self.columns = 3
            self.rows = 6
        case .veryHard:
            self.columns = 4
            self.rows = 6
        case .emotionalDamage:
            self.columns = 4
            self.rows = 8
        }
    }
}
