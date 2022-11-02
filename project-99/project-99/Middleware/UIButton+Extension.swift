//
//  UIButton+Extension.swift
//  project-99
//
//  Created by Patrick on 21.10.2022..
//

import UIKit

extension UIButton {
    func setupInView(_ view: UIView, withName name: String, andAction action: Selector) {
        self.setTitle(name, for: .normal)
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 4
        self.layer.cornerRadius = 4
        self.addTarget(view, action: action, for: .touchUpInside)
    }
}
