//
//  ColorContainer.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import UIKit

class ColorContainer {
    static var shared = ColorContainer()
    private var currentTheme: Theme = .system {
        didSet {
            changeColorsForTheme(currentTheme)
        }
    }

    var backgroundColor: UIColor = UIColor(named: "BackgroundColor")! {
        didSet {
            backgroundColorDidChange()
        }
    }
    
    var textColor: UIColor = UIColor(named: "TextColor")!
    var textFieldBackgroundColor: UIColor = UIColor(named: "TextFieldBackground")!

    private var backgroundColorObserver: ((UIColor) -> Void)?

    private func backgroundColorDidChange() {
        guard let backgroundColorObserver = backgroundColorObserver else {
            return
        }
        backgroundColorObserver(backgroundColor)
    }

    func bindBackGroundColor(_ closure: @escaping ((UIColor) -> Void)){
        self.backgroundColorObserver = closure
        backgroundColorDidChange()
    }

    func changeTheme(to theme: Theme) {
        self.currentTheme = theme
    }

    private func changeColorsForTheme(_ theme: Theme) {
        switch currentTheme {
        case .light:
            backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            textFieldBackgroundColor = UIColor(red: 0.820, green: 0.820, blue: 0.820, alpha: 1)
        case .dark:
            backgroundColor = UIColor(red: 0.103, green: 0.103, blue: 0.103, alpha: 1)
            textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            textFieldBackgroundColor = UIColor(red: 0.138, green: 0.138, blue: 0.138, alpha: 1)
        case .system:
            backgroundColor = UIColor(named: "BackgroundColor")!
            textColor = UIColor(named: "TextColor")!
            textFieldBackgroundColor = UIColor(named: "TextFieldBackground")!
        }
    }
}
