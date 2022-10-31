//
//  GameOptionViewCellModel.swift
//  project-99
//
//  Created by Patrick on 31.10.2022..
//

import Foundation

struct GameOptionViewCellModel: Hashable {
    var cellType: GameOption
    var title: String
    var value: Bool

    init(with option: GameOption, and viewModel: SettingsViewModel) {
        self.cellType = option

        switch option {
        case .multicolor:
            self.title = "Multicolor:"
            if let withMulticolor = viewModel.provideUserMulticolorState() {
                self.value = withMulticolor
            } else {
                self.value = false
            }
        case .timer:
            self.title = "Timer:"
            if let withTimer = viewModel.provideUserTimerState() {
                self.value = withTimer
            } else {
                self.value = false
            }
        }
    }
}
