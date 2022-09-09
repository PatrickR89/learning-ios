//
//  ShareViewModelDelegate.swift
//  challenge-d90-withMVVM-share
//
//  Created by Patrick on 09.09.2022..
//

import UIKit

protocol ShareViewModelDelegate: AnyObject {
    func shareViewModel(_ viewModel: ShareViewModel, didCancelRequestWithError error: Error?)
    func shareViewModel(_ viewModel: ShareViewModel, didCompleteRequestWith array: [Any]?)
}
