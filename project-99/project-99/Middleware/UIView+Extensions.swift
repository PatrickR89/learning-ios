//
//  UIView+Extensions.swift
//  project-99
//
//  Created by Patrick on 20.09.2022..
//

import UIKit

extension UIView {
    func setupCellViewUI(withLabels titleLabel: UILabel, and valueLabel: UILabel) {
        self.addSubview(titleLabel)
        self.addSubview(valueLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.textColor = .systemBlue

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            valueLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor)
        ])
    }
}
