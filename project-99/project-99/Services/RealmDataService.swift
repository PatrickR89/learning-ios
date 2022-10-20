//
//  RealmDataService.swift
//  project-99
//
//  Created by Patrick on 11.10.2022..
//

import Foundation
import RealmSwift
import Combine

class RealmDataService {
    static let shared = RealmDataService()
    private var cancellable: AnyCancellable?
    private var realm: Realm
    private var userId: UUID?

    init() {
        self.userId = UserContainer.shared.loadUser()
        self.realm = RealmDataProvider.shared.initiateRealm()
        bindUserId()
    }

    deinit {
        cancellable?.cancel()
    }

    private func bindUserId() {
        self.cancellable = UserContainer.shared.$userId
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] userId in
            self?.userId = userId
        })
    }

    func loadStatistics() -> UserGamesStats {
        guard let userId = userId,
              let result = realm.object(ofType: UserGamesStats.self, forPrimaryKey: userId) else {
            fatalError("user game stats could not be found")
        }
        return result
    }

    // MARK: Create new user

    func saveNewUser(_ newUser: User) {

        let newSettings = UserSettings(
            userId: newUser.id,
            theme: .system,
            withMulticolor: false,
            withTimer: false)

        let newStats = UserGamesStats(
            userId: newUser.id,
            numberOfGames: 0,
            numOfGamesWon: 0,
            cardsClicked: 0,
            pairsRevealed: 0,
            totalPlayTime: 0.0)

        let initialTimes = LevelTimes(
            userId: newUser.id,
            veryEasy: 0.0,
            easy: 0.0,
            mediumHard: 0.0,
            hard: 0.0,
            veryHard: 0.0,
            emotionalDamage: 0.0)

        try? realm.write {
            realm.add(newUser)
            realm.add(newSettings)
            realm.add(newStats)
            realm.add(initialTimes)
        }
    }

    // MARK: User

    func findUserByName(_ username: String) -> Results<User> {
        let result = realm.objects(User.self).where {
            $0.name == username
        }

        return result
    }

    func changeUsername(with newUsername: String) {
        guard let userId = userId,
              let user = realm.object(ofType: User.self, forPrimaryKey: userId) else {
            return
        }

        try? realm.write {
            user.name = newUsername
        }
    }

    func changePassword(with newPassword: String) {
        guard let userId = userId,
              let user = realm.object(ofType: User.self, forPrimaryKey: userId) else {
            return
        }

        try? realm.write {
            user.password = newPassword
        }
    }

    func deleteAccount() {
        guard let userId = userId else {
            return
        }

        if let levelTimes = realm.object(ofType: LevelTimes.self, forPrimaryKey: userId) {
            try? realm.write {
                realm.delete(levelTimes)
            }
        }

        if let userSettings = realm.object(ofType: UserSettings.self, forPrimaryKey: userId) {
            try? realm.write {
                realm.delete(userSettings)
            }
        }

        if let userGameStats = realm.object(ofType: UserGamesStats.self, forPrimaryKey: userId) {
            try? realm.write {
                realm.delete(userGameStats)
            }
        }

        if let user = realm.object(ofType: User.self, forPrimaryKey: userId) {
            try? realm.write {
                realm.delete(user)
            }
        }
    }

    // MARK: Game stats

    private func loadGameStats() -> UserGamesStats {
        guard let userId = userId,
              let result = realm.object(
                ofType: UserGamesStats.self,
                forPrimaryKey: userId) else {
            fatalError("user stats could not be loaded")
        }

        return result
    }

    func loadLevelTimes() -> LevelTimes {
        guard let userId = userId,
              let result = realm.object(
                ofType: LevelTimes.self,
                forPrimaryKey: userId) else {
            fatalError("user level times could not be found")
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

    // MARK: UserSettings

    func loadUserSettings(forUser id: UUID) -> UserSettings {
        guard let result = realm.object(
            ofType: UserSettings.self,
            forPrimaryKey: id) else {
            fatalError("user settings could not be loaded")
        }

        return result
    }

    func saveTheme(save theme: ThemeChoice) {
        guard let userId = userId else {
            return
        }

        let result = loadUserSettings(forUser: userId)
        print(result.theme)
        try? realm.write {
            result.theme = theme
        }
    }

    func saveMulticolorState(save state: Bool) {
        guard let userId = userId else {
            return
        }
        let result = loadUserSettings(forUser: userId)
        try? realm.write {
            result.withMulticolor = state
        }

    }

    func saveTimerState(save state: Bool) {
        guard let userId = userId else {
            return
        }
        let result = loadUserSettings(forUser: userId)
        try? realm.write {
            result.withTimer = state
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

    func loadTheme() -> ThemeChoice {
        guard let userId = userId,
              let result = realm.object(ofType: UserSettings.self, forPrimaryKey: userId) else {
            return .system
        }

        return result.theme
    }
}
