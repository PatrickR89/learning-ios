//
//  GameViewModelDelegate.swift
//  project-99
//
//  Created by Patrick on 10.10.2022..
//

import Foundation

protocol GameViewModelDelegate: AnyObject {
    func gameViewModelDidEndGame(_ viewModel: GameViewModel)
}
