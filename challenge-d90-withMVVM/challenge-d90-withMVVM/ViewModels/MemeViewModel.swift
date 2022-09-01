//
//  MemeViewModel.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

class MemeViewModel {
    private var meme: Meme = Meme(image: "", topText: false, bottomText: false) {
        didSet {
            valueDidChange()
            imageDidLoad(image: meme.image)
        }
    }

    weak var delegate: MemeViewModelDelegate?
    private var imageViewModel: ImageViewModel?
    private var memeVCViewModel: MemeVCViewModel?

    private var observer: ((UIImage) -> Void)?

    private func valueDidChange() {
        let path = FileManager.default.getFilePath(meme.image)
        guard let observer = observer,
              let image = UIImage(contentsOfFile: path.path) else {
            return
        }
        observer(image)
    }
}

extension MemeViewModel {
    func observeImage(_ closure: @escaping (UIImage) -> Void) {
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
            self.meme = Meme(image: "", topText: false, bottomText: false)
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

    func appendImageViewModel(_ imageViewModel: ImageViewModel) {
        self.imageViewModel = imageViewModel
        imageViewModel.delegate = self
    }

    func appendMemeVCViewModel(_ memeVCViewModel: MemeVCViewModel) {
        self.memeVCViewModel = memeVCViewModel
        memeVCViewModel.delegate = self
    }
}
