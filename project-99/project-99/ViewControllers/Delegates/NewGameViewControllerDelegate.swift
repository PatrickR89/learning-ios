//
//  NewGameViewControllerDelegate.swift
//  project-99
//
//  Created by Patrick on 27.10.2022..
//

import Foundation

protocol NewGameViewControllerDelegate: AnyObject {
    func newGameViewControllerDidRequestDismiss(_ viewController: NewGameViewController)
    func newGameViewController(
        _ viewController: NewGameViewController,
        didStartNewGameWithViewModel viewModel: GameVCViewModel,
        and stopwatch: Stopwatch)
}
