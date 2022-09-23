//
//  TimesSubviewCellViewModel.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import Foundation
import RealmSwift

class TimesCellBottomViewModel {
    private var realm: Realm

    private var times = [BestTimes]() {
        didSet {
            valueDidChange()
        }
    }

    private var isViewHidden: Bool = true {
        didSet {
            hideValueDidChange()
            delegate?.timesCellBottomViewModel(self, didChangeViewHiddenState: isViewHidden)
        }
    }

    private var observer: (([BestTimes]) -> Void)?
    private var hiddenObserver: ((Bool) -> Void)?

    weak var delegate: TimesCellBottomViewModelDelegate?

    init() {
        self.realm = RealmDataService.shared.initiateRealm()

    }

    private func valueDidChange() {
        guard let observer = observer else {
            return
        }
        observer(times)
    }

    private func hideValueDidChange() {
        guard let hiddenObserver = hiddenObserver else {
            return
        }
        hiddenObserver(isViewHidden)
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

    func observeHiddenState(_ closure: @escaping (Bool) -> Void) {
        self.hiddenObserver = closure
        hideValueDidChange()
    }

    func changeHiddenState(_ state: Bool) {
        self.isViewHidden = state
    }
}
