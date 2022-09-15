//
//  UserGames.swift
//  project-99
//
//  Created by Patrick on 15.09.2022..
//

import UIKit
import RealmSwift

class UserGamesStats: Object {
    @Persisted (primaryKey: true) var userId: UUID
    @Persisted var numberOfGames: Int
    @Persisted var numOfGamesWon: Int
    @Persisted var cardsClicked: Int
    @Persisted var pairsRevealed: Int
    @Persisted var totalPlayTime: Double

    convenience init(userId: UUID, numberOfGames: Int, numOfGamesWon: Int, cardsClicked: Int, pairsRevealed: Int, totalPlayTime: Double) {
        self.init()
        self.userId = userId
        self.numberOfGames = numberOfGames
        self.numOfGamesWon = numOfGamesWon
        self.cardsClicked = cardsClicked
        self.pairsRevealed = pairsRevealed
        self.totalPlayTime = totalPlayTime
    }
}
