//
//  NewGameViewModel.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import Foundation

class NewGameViewModel {
    weak var actions: NewGameViewModelActions?
    private var levels: [Level] = [.veryEasy, .easy, .mediumHard, .hard, .veryHard, .emotionalDamage]

    func loadLevel(at index: Int) {
        actions?.newGameViewModel(self, didStartNewLevel: levels[index])
    }

    func requestDismiss() {
        actions?.newGameViewModelDidRequestDismiss(self)
    }
}
