//
//  UIStackView+Extension.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import UIKit

extension UIStackView {
    func arrangeView(withButtons buttons: [UIButton]) {

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

    func arrangeView(asExpandableWith topView: UIView, and bottomView: UIView, bottomIsHidden hidden: Bool) {
        self.addArrangedSubview(topView)

        NSLayoutConstraint.activate([
            topView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            topView.widthAnchor.constraint(equalTo: self.widthAnchor),
            topView.topAnchor.constraint(equalTo: self.topAnchor)
        ])

        if !hidden {
            self.addArrangedSubview(bottomView)
            bottomView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                bottomView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                bottomView.widthAnchor.constraint(equalTo: self.widthAnchor)
            ])
        }
    }

    func arrangeView(asRowWith titleLable: UILabel, and valueLabel: UILabel) {

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

    func arrangeView(asColumnWithViews viewRows: [UIView], withSpacing spacing: CGFloat) {

        self.translatesAutoresizingMaskIntoConstraints = false

        self.axis = .vertical
        self.distribution = .fillEqually
        self.spacing = spacing

        if viewRows.count < 2 {
            self.alignment = .center
        } else {
            self.alignment = .top
        }

        for row in viewRows {
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

    func setupConstraints(forView view: UIView) {
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ])
    }
}
