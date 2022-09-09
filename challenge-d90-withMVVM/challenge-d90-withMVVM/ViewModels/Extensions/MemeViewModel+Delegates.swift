//
//  MemeViewModel+Delegates.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

extension MemeViewModel: MemeVCViewModelDelegate {
    func memeVCViewModel(_ viewModel: MemeVCViewModel, didSaveImageWithName imageName: String) {
        let meme = Meme(imageName: imageName, hasTopText: false, hasBottomText: false, dateAdded: Date.now)
        updateMeme(meme)
    }

    func memeVCViewModel(_ viewModel: MemeVCViewModel, didEditMeme meme: Meme) {
        updateMeme(meme)
    }

    func memeVCViewModel(_ viewModel: MemeVCViewModel, didDeleteMeme meme: Meme) {
        deleteMeme(meme)
    }

    func memeVCViewModelDidRequestMeme(_ viewModel: MemeVCViewModel) -> Meme {
        guard let meme = returnMeme() else {return Meme(
            imageName: "",
            hasTopText: false,
            hasBottomText: false,
            dateAdded: Date.now)}

        return meme
    }
}