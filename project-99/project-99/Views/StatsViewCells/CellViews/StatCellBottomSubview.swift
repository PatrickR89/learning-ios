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

    init() {
        super.init(frame: .zero)
        setupUI()

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

    func setupUI() {
        self.addSubview(tableStackView)

        totalStackView.arrangeView(asRowWith: totalLabel, and: totalValueLabel)
        wonStackView.arrangeView(asRowWith: wonLabel, and: wonValueLabel)
        rateStackView.arrangeView(asRowWith: rateLabel, and: rateValueLabel)

        let rows = [totalStackView, wonStackView, rateStackView]

        tableStackView.arrangeView(asColumnWith: rows)

        totalLabel.text = "Games played:"
        totalValueLabel.text = "0"
        wonLabel.text = "Games won:"
        wonValueLabel.text = "0"
        rateLabel.text = "Success rate:"
        rateValueLabel.text = "0%"

        NSLayoutConstraint.activate([
            tableStackView.topAnchor.constraint(equalTo: self.topAnchor),
            tableStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            tableStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.heightAnchor.constraint(equalTo: tableStackView.heightAnchor)
        ])
    }
}
