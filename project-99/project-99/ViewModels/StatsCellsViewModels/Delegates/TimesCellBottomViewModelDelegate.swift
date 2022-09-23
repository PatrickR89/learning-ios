//
//  TimesCellBottomViewModelDelegate.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import Foundation

protocol TimesCellBottomViewModelDelegate: AnyObject {
    func timesCellBottomViewModel(_ viewModel: TimesCellBottomViewModel, didChangeViewHiddenState: Bool)
}
