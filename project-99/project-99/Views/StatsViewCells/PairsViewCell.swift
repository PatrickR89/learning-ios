//
//  PairsViewCell.swift
//  project-99
//
//  Created by Patrick on 21.09.2022..
//

import UIKit

class PairsViewCell: UITableViewCell {

    private let stackView = UIStackView()
    private let topView = StatCellTopSubview()
    var bottomView: StatCellBottomSubview

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.bottomView = StatCellBottomSubview(
            as: StatsContent.pairs)
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
        setupUI(withExpandableView: stackView)
        stackView.arrangeView(asExpandableWith: topView, and: bottomView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
}
