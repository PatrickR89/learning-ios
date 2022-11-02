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

        do {
            try realm.write {
                realm.add(newUser)
                realm.add(newSettings)
                realm.add(newStats)
                realm.add(initialTimes)
            }
        } catch {
            fatalError("App crashed trying to save new user")
        }
    }

    // MARK: User

    func findUserByName(_ username: String) -> Results<User> {
        let result = realm.objects(User.self).where {
            $0.name == username
        }

        return result
    }

    func changeUsername(_ newUsername: String) {
        guard let userId = userId,
              let user = realm.object(ofType: User.self, forPrimaryKey: userId) else {
            return
        }

        do {
            try realm.write {
                user.name = newUsername
            }
        } catch {
            fatalError("Game crashed while updating username")
        }

    }

    func changePassword(_ newPassword: String) {
        guard let userId = userId,
              let user = realm.object(ofType: User.self, forPrimaryKey: userId) else {
            return
        }

        do {
            try realm.write {
                user.password = newPassword
            }
        } catch {
            fatalError("Game crashed while updating password")
        }

    }

    func deleteAccount() {
        guard let userId = userId else {
            return
        }
        do {
            if let levelTimes = realm.object(ofType: LevelTimes.self, forPrimaryKey: userId) {

                try realm.write {
                    realm.delete(levelTimes)
                }
            }

            if let userSettings = realm.object(ofType: UserSettings.self, forPrimaryKey: userId) {
                try realm.write {
                    realm.delete(userSettings)
                }
            }

            if let userGameStats = realm.object(ofType: UserGamesStats.self, forPrimaryKey: userId) {
                try realm.write {
                    realm.delete(userGameStats)
                }
            }

            if let user = realm.object(ofType: User.self, forPrimaryKey: userId) {

                try realm.write {
                    realm.delete(user)
                }
            }
        } catch {
            fatalError("Game crashed while trying to delete user and their content")
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

        do {
            try realm.write {
                result.numberOfGames += 1
            }
        } catch {
            fatalError("Game crashed while updating number of games started")
        }

    }

    func updateGamesWon() {
        let result = loadGameStats()

        do {
            try realm.write {
                result.numOfGamesWon += 1
            }
        } catch {
            fatalError("Game crashed while updating number of games won")
        }
    }

    func updateTotalSelectedPairs() {
        let result = loadGameStats()

        do {
            try realm.write {
                result.cardsClicked += 1
            }
        } catch {
            fatalError("Game crashed while updating count of pairs selected")
        }
    }

    func updatePairedCards() {
        let result = loadGameStats()

        do {
            try realm.write {
                result.pairsRevealed += 1
            }
        } catch {
            fatalError("Game crashed while updating count of pairs revealed")
        }
    }

    func saveNewTime(_ time: Double, for level: Level) {
        guard let userId = userId,
              let result = realm.object(ofType: LevelTimes.self, forPrimaryKey: userId) else {
            return
        }

        if result.value(forKey: level.rawValue) as? Double == 0.0 {
            do {
                try realm.write {
                    result.setValue(time, forKey: level.rawValue)
                }
            } catch {
                fatalError("Game crashed while saving new time for level \(level.rawValue)")
            }

        }

        if let levelTime = result.value(forKey: level.rawValue) as? Double {
            if time < levelTime {
                do {
                    try realm.write {
                        result.setValue(time, forKey: level.rawValue)
                    }
                } catch {
                    fatalError("Game crashed while saving new time for level \(level.rawValue)")
                }

            }
        }
    }

    // MARK: UserSettings

    func loadUserSettingsById(_ id: UUID) -> UserSettings? {
        guard let result = realm.object(
            ofType: UserSettings.self,
            forPrimaryKey: id) else {
            return nil
        }

        return result
    }

    func saveTheme(_ theme: ThemeChoice) {
        guard let userId = userId,
              let result = loadUserSettingsById(userId) else {
            return
        }

        do {
            try realm.write {
                result.theme = theme
            }
        } catch {
            fatalError("Game crashed while saving chosen theme")
        }

    }

    func saveMulticolorState(_ state: Bool) {
        guard let userId = userId,
              let result = loadUserSettingsById(userId) else {
            return
        }
        do {
            try realm.write {
                result.withMulticolor = state
            }
        } catch {
            fatalError("Game crashed while saving multicolor state")
        }
    }

    func saveTimerState(_ state: Bool) {
        guard let userId = userId,
              let result = loadUserSettingsById(userId) else {
            return
        }

        do {
            try realm.write {
                result.withTimer = state
            }
        } catch {
            fatalError("Game crashed while saving timer state")
        }

    }

    func loadMulticolorState() -> Bool {
        guard let userId = userId,
              let result = realm.object(ofType: UserSettings.self, forPrimaryKey: userId) else {
            return false
        }
        return result.withMulticolor
    }

    func loadTimerState() -> Bool {
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
