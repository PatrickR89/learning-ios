//
//  MainMenuViewDelegate.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import Foundation

protocol MainMenuViewDelegate: AnyObject {
    func mainMenuView(_ view: MainMenuView, didTapOnSettingsForUser user: User?)
    func mainMenuView(_ view: MainMenuView, didTapOnStatsForUser user: User?)
}
