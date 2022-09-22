//
//  GamesBottomSubview.swift
//  project-99
//
//  Created by Patrick on 20.09.2022..
//

import UIKit

class StatCellBottomSubview: UIView {

    private let totalsView = LabelLayout()
    private let winsView = LabelLayout()
    private let rateView = LabelLayout()
    private let labelStack = UIStackView()

    let viewModel: StatCellBottomViewModel

    init(with viewModel: StatCellBottomViewModel, as cellType: StatsContent) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupBindings()
        setupUI(as: cellType)
        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupBindings() {
        viewModel.observeValues { value in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.totalsView.addValue("\(value.totalValue)")
                self.winsView.addValue("\(value.positiveValue)")
                if value.totalValue != 0 {
                    let rate = (value.positiveValue / value.totalValue) * 100
                    self.rateView.addValue("\(rate)%")
                } else {
                    self.rateView.addValue("0.00%")
                }
            }
        }

        viewModel.observeHiddenState { state in
            DispatchQueue.main.async { [weak self] in
                self?.isHidden = state
            }
        }
    }

    func setupUI(as cellType: StatsContent) {
        self.addSubview(labelStack)

        let views: [UIView] = [totalsView, winsView, rateView]

        labelStack.arrangeView(asColumnWith: views)

        switch cellType {
        case .games:
            totalsView.addTitle("Games played:")
            winsView.addTitle("Games won:")
            rateView.addTitle("Success rate:")
        case .pairs:
            totalsView.addTitle("Total pairs:")
            winsView.addTitle("Pairs removed:")
            rateView.addTitle("Success rate:")
        case .time:
            break
        }

        NSLayoutConstraint.activate([
            labelStack.topAnchor.constraint(equalTo: self.topAnchor),
            labelStack.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            labelStack.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
