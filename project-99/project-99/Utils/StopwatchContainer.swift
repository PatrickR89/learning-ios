//
//  StopwatchContainer.swift
//  project-99
//
//  Created by Patrick on 07.11.2022..
//

import Foundation
import Combine

class StopwatchContainer {
    @Published private(set) var stopwatchTimer: StopwatchTimer?

    func toggleTimer() {
        let isTimer = RealmDataService.shared.loadTimerState()

        if isTimer {
            self.stopwatchTimer = StopwatchTimer()
        }
    }

    func dismissTimer() {
        self.stopwatchTimer = nil
    }
}
