//
//  TimesSubviewCellViewModel.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import Foundation
import Combine

class TimesCellBottomViewModel {

    @Published private(set) var times = [BestTime]()

    private var isViewHidden: Bool = true {
        didSet {
            delegate?.timesCellBottomViewModel(self, didChangeViewHiddenState: isViewHidden)
        }
    }

    weak var delegate: TimesCellBottomViewModelDelegate?

    func loadTimes() {
        let result = RealmDataService.shared.loadLevelTimes()

        times = [BestTime(title: .veryEasy, time: result.veryEasy), BestTime(title: .easy, time: result.easy),
                 BestTime(title: .mediumHard, time: result.mediumHard), BestTime(title: .hard, time: result.hard),
                 BestTime(title: .veryHard, time: result.veryHard),
                 BestTime(title: .emotionalDamage, time: result.emotionalDamage)
        ]
    }

    func provideTimesLength() -> Int {
        return times.count
    }

    func provideSingleTimeByIndex(for index: Int) -> BestTime {

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

    func changeHiddenState(_ state: Bool) {
        self.isViewHidden = state
    }
}
