//
//  TimesViewCell.swift
//  project-99
//
//  Created by Patrick on 22.09.2022..
//

import UIKit

class TimesViewCell: UITableViewCell {

    private let stackView = UIStackView()
    private let topView: StatCellTopSubview
    var bottomView: TimesCellBottomSubview

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.bottomView = TimesCellBottomSubview(cellType: .gameTimes)
        self.topView = StatCellTopSubview(as: StatsContent.gameTimes, isExtended: !self.bottomView.isHidden)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        stackView.arrangeView(asExpandableWith: topView, and: bottomView, bottomIsHidden: self.bottomView.isHidden)
        setupUI(withExpandableView: stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
}
