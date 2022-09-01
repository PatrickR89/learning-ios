//
//  ImageViewModelDelegate.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

protocol ImageViewModelDelegate: AnyObject {
    func imageViewModel(_ viewModel: ImageViewModel, didSaveImageWithName imageName: String)
}
