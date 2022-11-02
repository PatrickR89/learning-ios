//
//  UIStackView+Extension.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import UIKit

extension UIStackView {
    func arrangeButtons(_ buttons: [UIButton]) {

        self.translatesAutoresizingMaskIntoConstraints = false

        self.axis = .vertical
        self.distribution = .equalCentering
        self.alignment = .top
        self.spacing = 20

        for button in buttons {
            self.addArrangedSubview(button)
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                button.heightAnchor.constraint(equalToConstant: 35),
                button.widthAnchor.constraint(equalTo: self.widthAnchor)
            ])
        }
    }

    func arrangeExpandableViews(top: UIView, bottom: UIView, isBottomHidden: Bool) {
        self.addArrangedSubview(top)

        NSLayoutConstraint.activate([
            top.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            top.widthAnchor.constraint(equalTo: self.widthAnchor),
            top.topAnchor.constraint(equalTo: self.topAnchor)
        ])

        if !isBottomHidden {
            self.addArrangedSubview(bottom)
            bottom.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                bottom.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                bottom.widthAnchor.constraint(equalTo: self.widthAnchor)
            ])
        }
    }

    func arrangeRow(with titleLable: UILabel, and valueLabel: UILabel) {

        valueLabel.textColor = .systemBlue

        self.translatesAutoresizingMaskIntoConstraints = false

        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.alignment = .center
        self.spacing = 20

        self.addArrangedSubview(titleLable)
        self.addArrangedSubview(valueLabel)

        NSLayoutConstraint.activate([
            titleLable.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    func arrangeColumn(_ rows: [UIView], withSpacing spacing: CGFloat) {

        self.translatesAutoresizingMaskIntoConstraints = false

        self.axis = .vertical
        self.distribution = .fillEqually
        self.spacing = spacing

        if rows.count < 2 {
            self.alignment = .center
        } else {
            self.alignment = .top
        }

        for row in rows {
            self.addArrangedSubview(row)

            NSLayoutConstraint.activate([
                row.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                row.widthAnchor.constraint(equalTo: self.widthAnchor)
            ])

            if let row = row as? UITextField {
                NSLayoutConstraint.activate([
                    row.heightAnchor.constraint(equalToConstant: 35)])
            }
        }
    }

    func setupConstraints(_ view: UIView) {
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ])
    }
}
