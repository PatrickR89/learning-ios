//
//  MemeViewModel.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

class MemeViewModel {
    private var meme: Meme = Meme(imageName: "", hasTopText: false, hasBottomText: false, dateAdded: Date.now) {
        didSet {
            valueDidChange()
            imageDidLoad(image: meme.imageName)
        }
    }

    private var topText: String = "" {
        didSet {
            print(topText)
        }
    }
    private var bottomText: String = "" {
        didSet {
            print(bottomText)
        }
    }

    weak var delegate: MemeViewModelDelegate?
    private var memeVCViewModel: MemeVCViewModel?

    private var observer: ((Meme) -> Void)?

    private func valueDidChange() {
        let path = FileManager.default.getFilePath(meme.imageName)
        guard let observer = observer else {
            return
        }
        observer(meme)
    }
}

extension MemeViewModel {
    func observeImage(_ closure: @escaping (Meme) -> Void) {
        self.observer = closure
        valueDidChange()
    }

    func updateMeme(_ meme: Meme) {
        self.meme = meme
        delegate?.memeViewModel(self, didChangeMeme: meme)
    }

    func loadMeme(_ meme: Meme?) {
        if let meme = meme {
            self.meme = meme
        } else {
            self.meme = Meme(imageName: "", hasTopText: false, hasBottomText: false, dateAdded: Date.now)
        }
    }

    func deleteMeme(_ meme: Meme) {
        delegate?.memeViewModel(self, didDeleteMeme: meme)
    }

    func returnMeme() -> Meme? {
        return meme
    }

    func imageDidLoad(image: String) {
        let state = image != ""
        delegate?.memeViewModel(self, didLoadMeme: state)
    }

    func appendMemeVCViewModel(_ memeVCViewModel: MemeVCViewModel) {
        self.memeVCViewModel = memeVCViewModel
        memeVCViewModel.delegate = self
    }

    func updateMemeText(with text: String, on position: Position) {
        switch position {
        case .top:
            self.topText = text
        case .bottom:
            self.bottomText = text
        }
    }
}
