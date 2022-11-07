//
//  MainMenuViewModelActions.swift
//  project-99
//
//  Created by Patrick on 04.11.2022..
//

import Foundation

protocol MainMenuViewModelActions: AnyObject {
    func viewModelDidLogOut(_ viewModel: MainMenuViewModel)
    func viewModel(_ viewModel: MainMenuViewModel, didOpenStatsFor user: User)
    func viewModel(_ viewModel: MainMenuViewModel, didOpenSettingsFor user: User)
    func viewModelDidOpenNewGame(_ viewModel: MainMenuViewModel)
}
