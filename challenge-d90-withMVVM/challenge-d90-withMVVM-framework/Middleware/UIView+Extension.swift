//
//  UIView+Extension.swift
//  challenge-d90-withMVVM-framework
//
//  Created by Patrick on 09.09.2022..
//

import UIKit

extension UIView {
    func setBackground() {
        let blur  = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = self.frame
        self.insertSubview(blurView, at: 0)
    }
}
