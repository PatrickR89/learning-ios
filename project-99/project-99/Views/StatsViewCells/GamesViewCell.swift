//
//  GamesViewCell.swift
//  project-99
//
//  Created by Patrick on 20.09.2022..
//

import UIKit

class GamesViewCell: UITableViewCell {

    private let stackView = UIStackView()
    private let topView: StatCellTopSubview
    let cellBottomViewModel: StatCellBottomViewModel
    var bottomView: StatCellBottomSubview

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.cellBottomViewModel = StatCellBottomViewModel(as: StatsContent.games)

        self.bottomView = StatCellBottomSubview(
            with: cellBottomViewModel, as: StatsContent.games)
        self.topView = StatCellTopSubview(as: StatsContent.games, isExtended: !self.bottomView.isHidden)
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
        setupUI(withExpandableView: stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
}

extension GamesViewCell: StatCellBottomViewModelDelegate {
    func statCellBottomViewModel(_ viewModel: StatCellBottomViewModel, didChangeViewHiddenState: Bool) {
        stackView.removeFromSuperview()
        setupUI()
        topView.viewModel.toggleExtension(with: self.bottomView.isHidden)
    }
}
