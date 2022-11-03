//
//  StatCell.swift
//  project-99
//
//  Created by Patrick on 03.11.2022..
//

import Foundation

import UIKit

class StatCell: UITableViewCell {

    private var stackView: UIStackView?
    private var topView: StatCellTopSubview?
    var bottomView: UIView?
    var cellBottomViewModel: StatCellBottomViewModel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.stackView = UIStackView()
        guard let topView = topView,
              let bottomView = bottomView,
        let stackView = stackView else {return}

        contentView.removeFromSuperview()

        stackView.arrangeExpandableViews(top: topView, bottom: bottomView, isBottomHidden: bottomView.isHidden)
        setupUI(withExpandableView: stackView, withBottomHiddenState: bottomView.isHidden)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }

    func updateCellData(_ model: StatCellModel) {
        self.topView = model.topView
        self.bottomView = model.bottomView
        self.cellBottomViewModel = model.viewModel

        self.cellBottomViewModel?.delegate = self
    }

    func changeBottomState(with value: Bool) {
        bottomView?.isHidden = value
        cellBottomViewModel?.changeHiddenState(value)
    }
}

extension StatCell: StatCellBottomViewModelDelegate {
    func statCellBottomViewModel(_ viewModel: StatCellBottomViewModel, didChangeViewHiddenState: Bool) {
        guard let topView = topView,
              let bottomView = bottomView else {return}
        if let stackView = stackView {
            stackView.removeFromSuperview()
        }

        setupUI()
        topView.viewModel.toggleExtension(with: bottomView.isHidden)
    }
}
