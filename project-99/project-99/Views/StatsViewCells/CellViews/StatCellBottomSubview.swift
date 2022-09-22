//
//  GamesBottomSubview.swift
//  project-99
//
//  Created by Patrick on 20.09.2022..
//

import UIKit

class StatCellBottomSubview: UIView {

    private let totalLabel = UILabel()
    private let totalValueLabel = UILabel()
    private let wonLabel = UILabel()
    private let wonValueLabel = UILabel()
    private let rateLabel = UILabel()
    private let rateValueLabel = UILabel()
    private let totalStackView = UIStackView()
    private let wonStackView = UIStackView()
    private let rateStackView = UIStackView()
    private let tableStackView = UIStackView()

    let viewModel: StatCellBottomViewModel

    init(with viewModel: StatCellBottomViewModel, as cellType: StatsContent) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupBindings()
        setupUI(as: cellType)
        let labels = [totalLabel, wonLabel, rateLabel]
        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor

            for label in labels {
                label.textColor = $1.textColor
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupBindings() {
        viewModel.observeValues { value in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.totalValueLabel.text = "\(value.totalValue)"
                self.wonValueLabel.text = "\(value.positiveValue)"
                if value.totalValue != 0 {
                    let rate = (value.positiveValue / value.totalValue) * 100
                    self.rateValueLabel.text = "\(rate)%"
                } else {
                    self.rateValueLabel.text = "0.00%"
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
        self.addSubview(tableStackView)

        totalStackView.arrangeView(asRowWith: totalLabel, and: totalValueLabel)
        wonStackView.arrangeView(asRowWith: wonLabel, and: wonValueLabel)
        rateStackView.arrangeView(asRowWith: rateLabel, and: rateValueLabel)

        let rows = [totalStackView, wonStackView, rateStackView]

        tableStackView.arrangeView(asColumnWith: rows)

        switch cellType {
        case .games:
            totalLabel.text = "Games played:"
            wonLabel.text = "Games won:"
            rateLabel.text = "Success rate:"
        case .pairs:
            totalLabel.text = "Total pairs:"
            wonLabel.text = "Pairs removed:"
            rateLabel.text = "Success rate:"
        case .time:
            break
        }

        NSLayoutConstraint.activate([
            tableStackView.topAnchor.constraint(equalTo: self.topAnchor),
            tableStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            tableStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
