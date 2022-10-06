//
//  GameViewModelDelegate.swift
//  project-99
//
//  Created by Patrick on 03.10.2022..
//

import Foundation

protocol GameViewModelDelegate: AnyObject {
    func gameViewModel(_ viewModel: GameViewModel, didChangeCardSelectionAt index: Int)
    func gameViewModel(_ viewModel: GameViewModel, didPairCardAt index: Int)
}
