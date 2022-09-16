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
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Current theme:"
        valueLabel.text = "dark"
        valueLabel.textColor = .systemBlue

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            valueLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor)
        ])
    }

    func changeValue(with newValue: Theme) {
        valueLabel.text = newValue.rawValue
    }
}
