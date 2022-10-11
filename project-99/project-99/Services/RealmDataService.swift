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

    func updateTotalGames() {
        guard let userId = userId,
              let result = realm.object(ofType: UserGamesStats.self, forPrimaryKey: userId) else {return}

        print(result.numberOfGames)

        try? realm.write {
            result.numberOfGames += 1
        }
    }

    func updateGamesWon() {
        guard let userId = userId,
              let result = realm.object(ofType: UserGamesStats.self, forPrimaryKey: userId) else {return}

        print(result.numOfGamesWon)

        try? realm.write {
            result.numOfGamesWon += 1
        }
    }
}
