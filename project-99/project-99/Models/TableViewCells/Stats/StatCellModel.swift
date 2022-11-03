//
//  StatCellModel.swift
//  project-99
//
//  Created by Patrick on 03.11.2022..
//

import UIKit

struct StatCellModel: Hashable {
    var isExtended: Bool
    var content: StatsContent
    var viewModel: StatCellBottomViewModel
    var bottomView: UIView
    var topView: StatCellTopSubview

    init(content: StatsContent, isExtended: Bool) {
        self.isExtended = isExtended
        self.content = content
        var bottomView: UIView
        switch content {
        case .gameTimes:
            let viewModel = TimesCellBottomViewModel(as: content)
            self.viewModel = viewModel
            bottomView = TimesCellBottomSubview(with: viewModel, cellType: content)
        default:
            let viewModel = StatCellBottomViewModel(as: content)
            self.viewModel = viewModel
            bottomView = StatCellBottomSubview(with: viewModel, as: content)
        }
        self.bottomView = bottomView
        self.topView = StatCellTopSubview(as: content, isExtended: isExtended)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(content)
    }
}

extension StatCellModel: Equatable {
    static func == (lhs: StatCellModel, rhs: StatCellModel) -> Bool {
        return lhs.content == rhs.content && lhs.isExtended == rhs.isExtended
    }
}
