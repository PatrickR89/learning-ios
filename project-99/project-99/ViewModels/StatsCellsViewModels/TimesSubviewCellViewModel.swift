//
//  TimesSubviewCellViewModel.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import Foundation
import Combine

class TimesCellBottomViewModel {

    @Published private(set) var times = [BestTimes]()

    private var isViewHidden: Bool = true {
        didSet {
            delegate?.timesCellBottomViewModel(self, didChangeViewHiddenState: isViewHidden)
        }
    }

    weak var delegate: TimesCellBottomViewModelDelegate?

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

    func changeHiddenState(_ state: Bool) {
        self.isViewHidden = state
    }
}
