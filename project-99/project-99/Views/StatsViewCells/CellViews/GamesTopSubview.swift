//
//  GamesTopSubview.swift
//  project-99
//
//  Created by Patrick on 20.09.2022..
//

import UIKit

class GamesTopSubview: UIView {

    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

    init() {
        super.init(frame: .zero)
        setupUI()

        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
            $0.titleLabel.textColor = $1.textColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.setupCellViewUI(withLabels: titleLabel, and: valueLabel)

        titleLabel.text = "Games"
        valueLabel.text = "0/0"
    }
}
