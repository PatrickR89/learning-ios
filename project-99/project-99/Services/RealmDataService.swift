//
//  RealmDataService.swift
//  project-99
//
//  Created by Patrick on 11.10.2022..
//

import Foundation
import RealmSwift

class RealmDataService {
    static let shared = RealmDataService()
    private var realm: Realm
    private var userId: UUID?

    init() {
        self.realm = RealmDataProvider.shared.initiateRealm()
        self.userId = UserContainer.shared.loadUser()
    }

    private func loadGameStats() -> UserGamesStats {
        guard let userId = userId,
              let result = realm.object(
                ofType: UserGamesStats.self,
                forPrimaryKey: userId) else {
            fatalError("user stats could not be loaded")
        }

        return result
    }

    func updateTotalGames() {
        let result = loadGameStats()

        try? realm.write {
            result.numberOfGames += 1
        }
    }

    func updateGamesWon() {
        let result = loadGameStats()

        try? realm.write {
            result.numOfGamesWon += 1
        }
    }

    func updateTotalSelectedPairs() {
        let result = loadGameStats()

        try? realm.write {
            result.cardsClicked += 1
        }
    }

    func updatePairedCards() {
        let result = loadGameStats()

        try? realm.write {
            result.pairsRevealed += 1
        }
    }

    func loadMulticolorValue() -> Bool {
        guard let userId = userId,
              let result = realm.object(ofType: UserSettings.self, forPrimaryKey: userId) else {
            return false
        }
        return result.withMulticolor
    }

    func loadTimerValue() -> Bool {
        guard let userId = userId,
              let result = realm.object(ofType: UserSettings.self, forPrimaryKey: userId) else {
            return false
        }

        return result.withTimer
    }

    func saveNewTime(save time: Double, for level: Level) {
        guard let userId = userId,
              let result = realm.object(ofType: LevelTimes.self, forPrimaryKey: userId) else {
            return
        }

        if result.value(forKey: level.rawValue) as? Double == 0.0 {
                try? realm.write {
                    result.setValue(time, forKey: level.rawValue)
                }
        }

        if let levelTime = result.value(forKey: level.rawValue) as? Double {
            if time < levelTime {
                try? realm.write {
                    result.setValue(time, forKey: level.rawValue)
                }
            }
        }
    }
}
