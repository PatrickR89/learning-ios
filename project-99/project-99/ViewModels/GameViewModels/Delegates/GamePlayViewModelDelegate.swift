//
//  GamePlayViewModelDelegate.swift
//  project-99
//
//  Created by Patrick on 27.10.2022..
//

import Foundation

protocol GamePlayViewModelDelegate: AnyObject {
    func gamePlayViewModelDidEndGame(_ viewModel: GamePlayViewModel, with result: EndGame)
}
