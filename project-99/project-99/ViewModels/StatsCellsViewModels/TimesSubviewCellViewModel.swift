//
//  TimesSubviewCellViewModel.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import Foundation
import RealmSwift

class TimesCellBottomModelView {
    private var realm: Realm

    private var times = [BestTimes]() {
        didSet {
            valueDidChange()
        }
    }

    private var observer: (([BestTimes]) -> Void)?

    init() {
        self.realm = RealmDataService.shared.initiateRealm()

    }

    private func valueDidChange() {
        guard let observer = observer else {
            return
        }
        observer(times)
    }

    func observeTimes(_ closure: @escaping ([BestTimes]) -> Void) {
        self.observer = closure
        valueDidChange()
    }

    func loadTimes() {
        guard let result = realm.object(
            ofType: LevelTimes.self,
            forPrimaryKey: UserContainer.shared.loadUser()) else {return}

        times.append(BestTimes(title: .veryEasy, time: result.veryEasy))
        times.append(BestTimes(title: .easy, time: result.easy))
        times.append(BestTimes(title: .mediumHard, time: result.mediumHard))
        times.append(BestTimes(title: .hard, time: result.hard))
        times.append(BestTimes(title: .veryHard, time: result.veryHard))
        times.append(BestTimes(title: .emotionalDamage, time: result.emotionalDamage))
    }

    func countTimesLength() -> Int {
        return times.count
    }

    func returnTimesElement(for index: Int) -> BestTimes {
        return times[index]
    }
}
