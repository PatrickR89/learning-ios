//
//  StatCellTopSubview.swift
//  project-99
//
//  Created by Patrick on 20.09.2022..
//

import UIKit

class StatCellTopSubview: UIView {

    private let titleLabel = UILabel()
    private let arrowView = UIImageView()
    private let viewModel: StatCellTopViewModel

    init(as cellType: StatsContent, isExtended bottomView: Bool) {
        self.viewModel = StatCellTopViewModel(with: cellType, for: bottomView)
        super.init(frame: .zero)
        setupUI()
        setupBindings()

        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
            $0.titleLabel.textColor = $1.textColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.setupCellViewUI(withLabels: titleLabel, and: nil)

        titleLabel.text = "Games"

    }

    func setupBindings() {
        viewModel.observeCellType { value in
            DispatchQueue.main.async { [weak self] in
                switch value {
                case .games:
                    self?.titleLabel.text = "Games"
                case .pairs:
                    self?.titleLabel.text = "Pairs"
                case .time:
                    self?.titleLabel.text = "Time"
                }
            }
        }
    }
}
