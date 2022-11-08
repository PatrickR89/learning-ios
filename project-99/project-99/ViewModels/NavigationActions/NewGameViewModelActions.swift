//
//  NewGameViewModelActions.swift
//  project-99
//
//  Created by Patrick on 07.11.2022..
//

import Foundation

protocol NewGameViewModelActions: AnyObject {
        func newGameViewModelDidRequestDismiss(_ viewModel: NewGameViewModel)
        func newGameViewModel(
            _ viewModel: NewGameViewModel,
            didStartNewLevel level: Level)
}