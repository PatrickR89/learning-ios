//
//  LevelTimes.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import Foundation
import RealmSwift

class LevelTimes: Object {
    @Persisted (primaryKey: true ) var userId: UUID
    @Persisted var veryEasy: Double
    @Persisted var easy: Double
    @Persisted var mediumHard: Double
    @Persisted var hard: Double
    @Persisted var veryHard: Double
    @Persisted var emotionalDamage: Double

    convenience init(
        userId: UUID,
        veryEasy: Double,
        easy: Double,
        mediumHard: Double,
        hard: Double,
        veryHard: Double,
        emotionalDamage: Double) {
            self.init()
            self.userId = userId
            self.veryEasy = veryEasy
            self.easy = easy
            self.mediumHard = mediumHard
            self.hard = hard
            self.veryHard = veryHard
            self.emotionalDamage = emotionalDamage
        }
}
