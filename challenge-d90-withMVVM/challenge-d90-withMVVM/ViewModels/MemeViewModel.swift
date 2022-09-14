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
            topTextDidChange()
            bottomTextDidChange()
            changeEditingStatus()
            imageDidLoad(image: meme.imageName)
        }
    }

    var topText: MemeText = MemeText(value: "", new: false) {
        didSet {
            addText(topText: topText.value, bottomText: bottomText.value)
            topTextDidChange()
            if topText.value != "" {
                changeEditingStatus()
            }
        }
    }

    var bottomText: MemeText = MemeText(value: "", new: false) {
        didSet {
            addText(topText: topText.value, bottomText: bottomText.value)
            bottomTextDidChange()
            if bottomText.value != "" {
                changeEditingStatus()
            }
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
    private var topTextObserver: ((String, Meme) -> Void)?
    private var bottomTextObserver: ((String, Meme) -> Void)?

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

    private func topTextDidChange() {
        guard let textObserver = topTextObserver else {
            return
        }
        textObserver(topText.value, meme)
    }

    private func bottomTextDidChange() {
        guard let textObserver = bottomTextObserver else {
            return
        }
        textObserver(bottomText.value, meme)
    }
}

extension MemeViewModel {
    func resetImageLayer() {
        imageLayer = nil
        topText.value = ""
        bottomText.value = ""
    }

    func changeEditingStatus() {
        guard meme.imageName != "" else {
            delegate?.memeViewModel(self, didEnableEditing: false)
            return
        }
        let memeHasChangableText = !meme.hasTopText || !meme.hasBottomText
        let memeHasEditabletext = topText.value != "" || bottomText.value != ""
        let status = memeHasChangableText && memeHasEditabletext
        delegate?.memeViewModel(self, didEnableEditing: status)
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

    func observeTopText(_ closure: @escaping (String, Meme) -> Void) {
        self.topTextObserver = closure
        topTextDidChange()
    }

    func observeBottomText(_ closure: @escaping (String, Meme) -> Void) {
        self.bottomTextObserver = closure
        bottomTextDidChange()
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
        self.meme = Meme(imageName: "", hasTopText: false, hasBottomText: false, dateAdded: Date.now)
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
            self.topText.value = text
            self.topText.new = true
        case .bottom:
            self.bottomText.value = text
            self.bottomText.new = true
        }
    }

    func saveChanges() {
        let imagePath = FileManager.default.getFilePath(meme.imageName)
        guard let image = UIImage(contentsOfFile: imagePath.path),
              let imageLayer = imageLayer else {return}

        let imageWithText = image.saveImage(with: imageLayer)
        if let jpegData = imageWithText.jpegData(compressionQuality: 0.5) {
            try? jpegData.write(to: imagePath)
        }

        updateMeme(meme)
    }
}
