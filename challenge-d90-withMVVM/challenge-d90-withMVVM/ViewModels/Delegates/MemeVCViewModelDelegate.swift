//
//  MemeVCViewModelDelegate.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

protocol MemeVCViewModelDelegate: AnyObject {
    func memeVCViewModel(_ viewModel: MemeVCViewModel, didEditMeme meme: Meme, with text: String, at position: Position)
    func memeVCViewModel(_ viewModel: MemeVCViewModel, didDeleteMeme meme: Meme)
    func memeVCViewModelDidRequestMeme(_ viewModel: MemeVCViewModel) -> Meme
    func memeVCViewModel(_ viewModel: MemeVCViewModel, didSaveImageWithName imageName: String)
    func memeVCViewModel(_ viewModel: MemeVCViewModel, didRequestText position: Position) -> MemeText
}
