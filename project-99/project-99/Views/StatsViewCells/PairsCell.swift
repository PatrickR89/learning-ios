//
//  PairsCell.swift
//  project-99
//
//  Created by Patrick on 21.09.2022..
//

import UIKit

class PairsCell: UITableViewCell {

    private let stackView = UIStackView()
    private let topView: StatCellTopSubview
    var bottomView: StatCellBottomSubview
    let cellBottomViewModel: StatCellBottomViewModel

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        self.cellBottomViewModel = StatCellBottomViewModel(as: StatsContent.pairs)
        self.bottomView = StatCellBottomSubview(
            with: cellBottomViewModel, as: StatsContent.pairs)
        self.topView = StatCellTopSubview(as: StatsContent.pairs, isExtended: self.bottomView.isHidden)
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
        stackView.arrangeExpandableViews(top: topView, bottom: bottomView, isBottomHidden: self.bottomView.isHidden)
        setupUI(withExpandableView: stackView, withBottomHiddenState: self.bottomView.isHidden)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
}

extension PairsCell: StatCellBottomViewModelDelegate {
    func statCellBottomViewModel(_ viewModel: StatCellBottomViewModel, didChangeViewHiddenState: Bool) {
        stackView.removeFromSuperview()
        setupUI()
        topView.viewModel.toggleExtension(with: self.bottomView.isHidden)
    }
}
