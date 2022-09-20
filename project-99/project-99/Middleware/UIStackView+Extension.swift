//
//  UIStackView+Extension.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import UIKit

extension UIStackView {
    func arrangeView(withButtons buttons: [UIButton]) {

        for button in buttons {
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 4
            button.layer.cornerRadius = 4
            self.addArrangedSubview(button)
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                button.heightAnchor.constraint(equalToConstant: 35),
                button.widthAnchor.constraint(equalTo: self.widthAnchor)
            ])
        }
    }

    func arrangeView(asExpandableWith topView: UIView, and bottomView: UIView) {
        self.addArrangedSubview(topView)

        NSLayoutConstraint.activate([
            topView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            topView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])

        if !bottomView.isHidden {
            self.addArrangedSubview(bottomView)
            NSLayoutConstraint.activate([
                bottomView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                bottomView.widthAnchor.constraint(equalTo: self.widthAnchor)
            ])
        }
    }
}
