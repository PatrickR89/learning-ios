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
            addText(topText: topText, bottomText: bottomText)
//            meme.hasTopText = true
        }
    }
    private var bottomText: String = "" {
        didSet {
            addText(topText: topText, bottomText: bottomText)
//            meme.hasBottomText = true
        }
    }

    private var imageLayer: UIImage? {
        didSet {
            if meme.imageName != "" {
                imageLayerDidChange()
            }
        }
    }

    weak var delegate: MemeViewModelDelegate?
    private var memeVCViewModel: MemeVCViewModel?

    private var observer: ((Meme) -> Void)?
    private var imageLayerObserver: ((UIImage) -> Void)?

    private func valueDidChange() {
        guard let observer = observer else {
            return
        }
        observer(meme)
    }

    private func imageLayerDidChange() {
        guard let imageLayerObserver = imageLayerObserver,
        let imageLayer = imageLayer else {
            return
        }
        imageLayerObserver(imageLayer)
    }
}

extension MemeViewModel {
    func resetImageLayer() {
        imageLayer = nil
    }

    func addText(topText: String, bottomText: String) {
        let path = FileManager.default.getFilePath(meme.imageName)
        guard let image = UIImage(contentsOfFile: path.path) else {return}
        imageLayer = image.addMemeText(topText: topText, bottomText: bottomText)
    }

    func observeMeme(_ closure: @escaping (Meme) -> Void) {
        self.observer = closure
        valueDidChange()
    }
    func observeImageLayer(_ closure: @escaping (UIImage) -> Void) {
        self.imageLayerObserver = closure
        imageLayerDidChange()
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
