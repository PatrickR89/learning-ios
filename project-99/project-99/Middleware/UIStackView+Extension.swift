//
//  UIStackView+Extension.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import UIKit

extension UIStackView {
    func arrangeView(with buttons: [UIButton]) {

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
}
