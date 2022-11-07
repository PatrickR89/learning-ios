//
//  NewGameViewModel.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import Foundation

class NewGameViewModel {
    weak var delegate: NewGameViewModelDelegate?
    private var levels: [Level] = [.veryEasy, .easy, .mediumHard, .hard, .veryHard, .emotionalDamage]

    func loadLevel(at index: Int) {
        delegate?.newGameViewModel(self, didStartNewLevel: levels[index])
    }

    func requestDismiss() {
        delegate?.newGameViewModelDidRequestDismiss(self)
    }
}
