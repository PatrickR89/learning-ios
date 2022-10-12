//
//  Stopwatch.swift
//  project-99
//
//  Created by Patrick on 12.10.2022..
//

import Foundation
import Combine

class Stopwatch {
    private var startTime: Date?
    private var timer: Cancellable?

    private var elapsedTime: TimeInterval = 0 {
        didSet {
            timeString = String(format: "%.2f", elapsedTime)
        }
    }
    @Published private(set) var timeString: String = "0.0"
    @Published private(set) var isTimerOff: Bool = !RealmDataService.shared.loadTimerValue()

    func startTimer() {
        timer?.cancel()
        if !isTimerOff {
            startTime = Date()
            self.timer = Timer.publish(every: 0.05, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                self.elapsedTime = self.getElapsedTime()
            }
        }
    }

    func resetTimer() {
        timer?.cancel()
        timer = nil
        startTime = nil
        elapsedTime = 0
    }

    func stopAndSaveTime(for game: Level) {
        timer?.cancel()
        timer = nil
        startTime = nil
        if !isTimerOff {
            RealmDataService.shared.saveNewTime(save: self.elapsedTime, for: game)
        }
        elapsedTime = 0
    }

    private func getElapsedTime() -> TimeInterval {
        return -(self.startTime?.timeIntervalSinceNow ?? 0)
    }
}
