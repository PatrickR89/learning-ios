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
    var cellBottomViewModel: TimesCellBottomViewModel

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.cellBottomViewModel = TimesCellBottomViewModel()
        self.bottomView = TimesCellBottomSubview(with: cellBottomViewModel, cellType: .gameTimes)
        self.topView = StatCellTopSubview(as: StatsContent.gameTimes, isExtended: !self.bottomView.isHidden)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.cellBottomViewModel.delegate = self
        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        stackView.arrangeView(asExpandableWith: topView, and: bottomView, bottomIsHidden: self.bottomView.isHidden)
        setupUI(withExpandableView: stackView, withBottomHiddenState: self.bottomView.isHidden)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
}

extension TimesViewCell: TimesCellBottomViewModelDelegate {
    func timesCellBottomViewModel(_ viewModel: TimesCellBottomViewModel, didChangeViewHiddenState: Bool) {
        setupUI()
        topView.viewModel.toggleExtension(with: self.bottomView.isHidden)
    }
}
