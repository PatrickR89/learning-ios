//
//  NewGameViewModel.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import Foundation

class NewGameViewModel {
    private var levels: [Level] = [.veryEasy, .easy, .mediumHard, .hard, .veryHard, .emotionalDamage]

    func loadLevel(at index: Int) -> Level {
        return levels[index]
    }

    func countLevels() -> Int {
        return levels.count
    }
}
