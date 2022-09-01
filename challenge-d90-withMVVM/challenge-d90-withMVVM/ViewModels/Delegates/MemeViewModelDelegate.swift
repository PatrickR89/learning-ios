//
//  MemeViewModelDelegate.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

protocol MemeViewModelDelegate: AnyObject {
    func memeViewModel(_ viewModel: MemeViewModel, didChangeMeme meme: Meme)
    func memeViewModel(_ viewModel: MemeViewModel, didDeleteMeme meme: Meme)
}
