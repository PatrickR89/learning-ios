//
//  StatCellModel.swift
//  project-99
//
//  Created by Patrick on 03.11.2022..
//

import UIKit

struct StatCellModel: Hashable {
    var id: UUID
    var content: StatsContent
    var viewModel: StatCellBottomViewModel
    var bottomView: UIView
    var topView: StatCellTopSubview

    init(content: StatsContent) {
        self.id = UUID()
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
        self.topView = StatCellTopSubview(as: content, isExtended: bottomView.isHidden)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension StatCellModel: Equatable {
    static func == (lhs: StatCellModel, rhs: StatCellModel) -> Bool {
        return lhs.id == rhs.id
    }
}
