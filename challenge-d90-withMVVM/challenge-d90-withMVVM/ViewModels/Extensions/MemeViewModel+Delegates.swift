//
//  MemeViewModel+Delegates.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

extension MemeViewModel: MemeVCViewModelDelegate {
    func memeVCViewModel(_ viewModel: MemeVCViewModel, didEditText text: String, at position: Position) {
        switch position {
        case .top:
            self.topText.value = text
        case .bottom:
            self.bottomText.value = text
        }
    }


    func memeVCViewModel(_ viewModel: MemeVCViewModel, didRequestText position: Position) -> MemeText {
        switch position {
        case .top:
            return self.topText
        case .bottom:
            return self.bottomText
        }
    }

    func memeVCViewModel(_ viewModel: MemeVCViewModel, didSaveImageWithName imageName: String) {
        let meme = Meme(imageName: imageName, hasTopText: false, hasBottomText: false, dateAdded: Date.now)
        topText.new = true
        bottomText.new = true
        updateMeme(meme)
    }

//    func memeVCViewModel(
//        _ viewModel: MemeVCViewModel,
//        didEditMeme meme: Meme,
//        with text: String,
//        at position: Position) {
//            resetImageLayer(false)
//            switch position {
//            case .top:
//                self.topText.value = text
//            case .bottom:
//                self.bottomText.value = text
//            }
//
//        }

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
