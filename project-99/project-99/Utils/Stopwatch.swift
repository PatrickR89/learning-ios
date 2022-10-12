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

    @Published private(set) var elapsedTime: TimeInterval = 0

    func startTimer() {
        print("timer start")
//        timer?.cancel()
//        startTime = Date()
//        self.timer = Timer.publish(every: 0.05, on: .main, in: .common)
//            .autoconnect()
//            .sink { _ in
//            self.elapsedTime = self.getElapsedTime()
//        }
    }

    func resetTimer() {
        print("timer reset")
//        timer?.cancel()
//        timer = nil
//        startTime = nil
//        elapsedTime = 0
    }

    func stopAndSaveTime(for game: Level) {
        print("timer stop")
//        timer?.cancel()
//        timer = nil
//        startTime = nil
//        elapsedTime = 0
    }

    private func getElapsedTime() -> TimeInterval {
        return -(self.startTime?.timeIntervalSinceNow ?? 0)
    }
}
