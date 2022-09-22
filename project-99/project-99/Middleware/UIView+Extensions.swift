//
//  UIView+Extensions.swift
//  project-99
//
//  Created by Patrick on 20.09.2022..
//

import UIKit

extension UIView {
    func setupCellViewUI(withLabels titleLabel: UILabel, and valueLabel: UILabel?) {
        self.addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        if let valueLabel = valueLabel {
            self.addSubview(valueLabel)
            valueLabel.translatesAutoresizingMaskIntoConstraints = false
            valueLabel.textColor = .systemBlue

            NSLayoutConstraint.activate([
                valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                valueLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor)
            ])
        }
    }

    func setupCellArrowImageView(for imageView: UIImageView) {
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
