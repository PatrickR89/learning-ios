//
//  StatsViewModelDelegate.swift
//  project-99
//
//  Created by Patrick on 22.09.2022..
//

import Foundation

protocol StatsViewModelDelegate: AnyObject {
    func statsViewModel(_ viewModel: StatsViewModel, didChangeStateAtIndex index: Int)
}
