//
//  TimesSubviewCellViewModel.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import Foundation

class TimesCellBottomViewModel {

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
        let result = RealmDataService.shared.loadLevelTimes()

        times = [BestTimes(title: .veryEasy, time: result.veryEasy), BestTimes(title: .easy, time: result.easy),
                 BestTimes(title: .mediumHard, time: result.mediumHard), BestTimes(title: .hard, time: result.hard),
                 BestTimes(title: .veryHard, time: result.veryHard),
                 BestTimes(title: .emotionalDamage, time: result.emotionalDamage)
        ]
    }

    func countTimesLength() -> Int {
        return times.count
    }

    func returnTimesElement(for index: Int) -> BestTimes {

        return times[index]
    }

    func converTimeTitle(for title: Level) -> String {

        switch title {
        case .veryEasy:
            return "Very easy"
        case .easy:
            return "Easy"
        case .mediumHard:
            return "Medium"
        case .hard:
            return "Hard"
        case .veryHard:
            return "Very hard"
        case .emotionalDamage:
            return "Emotional damage"
        }
    }

    func observeHiddenState(_ closure: @escaping (Bool) -> Void) {
        self.hiddenObserver = closure
        hideValueDidChange()
    }

    func changeHiddenState(_ state: Bool) {
        self.isViewHidden = state
    }
}
