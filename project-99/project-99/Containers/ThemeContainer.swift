//
//  ColorContainer.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import UIKit
import Themes

class ThemeContainer {
    static var shared = ThemeContainer()

    let lightTheme = AppTheme(
        name: "lightTheme",
        backgroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
        textColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
        textFieldBackground: UIColor(red: 0.820, green: 0.820, blue: 0.820, alpha: 1))
    let darkTheme = AppTheme(
        name: "darkTheme",
        backgroundColor: UIColor(red: 0.103, green: 0.103, blue: 0.103, alpha: 1),
        textColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
        textFieldBackground: UIColor(red: 0.138, green: 0.138, blue: 0.138, alpha: 1))
    let systemTheme = AppTheme(
        name: "systemTheme",
        backgroundColor: UIColor(named: "BackgroundColor")!,
        textColor: UIColor(named: "TextColor")!,
        textFieldBackground: UIColor(named: "TextFieldBackground")!)

    func changeTheme(to theme: ThemeChoice) {
        switch theme {
        case .light:
            ThemeManager.shared.currentTheme = lightTheme
        case .dark:
            ThemeManager.shared.currentTheme = darkTheme
        case .system:
            ThemeManager.shared.currentTheme = systemTheme
        }
    }
}
