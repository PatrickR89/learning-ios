//
//  UITextField+Extension.swift
//  project-99
//
//  Created by Patrick on 21.10.2022..
//

import UIKit

extension UITextField {

    func setupTextView() {

        self.textAlignment = .left
        self.textColor = .black
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.leftView = UIView(
            frame: CGRect(
                x: 0, y: 0, width: 10,
                height: self.frame.height))
        self.leftViewMode = .always
    }
}
