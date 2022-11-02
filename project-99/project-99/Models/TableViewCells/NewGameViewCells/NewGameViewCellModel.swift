//
//  NewGameViewCellModel.swift
//  project-99
//
//  Created by Patrick on 31.10.2022..
//

import Foundation

struct NewGameCellViewModel: Hashable {
    var level: Level
    var title: String
    var chances: String

    init(_ level: Level) {
        self.level = level
        switch level {
        case .veryEasy:
            self.title = "Very Easy"
            self.chances = "Lives: Unlimited"
        case .easy:
            self.title = "Easy"
            self.chances = "Lives: Unlimited"
        case .mediumHard:
            self.title = "Medium"
            self.chances = "Lives: 30"
        case .hard:
            self.title = "Hard"
            self.chances = "Lives: 30"
        case .veryHard:
            self.title = "Very hard"
            self.chances = "Lives: 15"
        case .emotionalDamage:
            self.title = "Emotional damage"
            self.chances = "Lives: 10"
        }
    }
}
