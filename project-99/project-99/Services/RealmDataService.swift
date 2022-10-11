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

    func updateTotalSelectedCards() {
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
}
