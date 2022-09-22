//
//  StatCellBottomViewModelDelegate.swift
//  project-99
//
//  Created by Patrick on 22.09.2022..
//

import Foundation

protocol StatCellBottomViewModelDelegate: AnyObject {
    func statCellBottomViewModel(_ viewModel: StatCellBottomViewModel, didChangeViewHiddenState: Bool)
}
