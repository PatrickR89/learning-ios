//
//  ThemeTableViewCell.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import UIKit

class ThemeTableViewCell: UITableViewCell {

    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
            $0.titleLabel.textColor = $1.textColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        setupUI(withLabels: titleLabel, and: valueLabel)
        titleLabel.text = "Current theme:"
        valueLabel.text = "dark"
    }

    func changeValue(with newValue: ThemeChoice) {
        valueLabel.text = newValue.rawValue
    }
}
