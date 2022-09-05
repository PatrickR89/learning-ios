//
//  MemesViewModel.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

class MemesViewModel {

    private var memes = [Meme](DataStorage.shared.loadFile()) {
        didSet {
            valueDidChange()
        }
    }

    private var index: Int? {
        didSet {
            memeValueDidChange()
        }
    }

    private var observer: (([Meme]) -> Void)?
    private var memeObserver: ((Meme) -> Void)?

    let memeViewModel = MemeViewModel()
    let memeVCViewModel = MemeVCViewModel()

    init() {
        memeViewModel.delegate = self
        memeViewModel.appendMemeVCViewModel(memeVCViewModel)
    }
}

private extension MemesViewModel {
    func valueDidChange() {
        guard let observer = observer else {
            return
        }
        observer(memes)
    }

    func memeValueDidChange() {
        guard let observer = memeObserver,
            let index = index else {return}
        observer(memes[index])
    }

    func findMemeIndex(_ meme: Meme) -> Int? {
        return memes.firstIndex(where: {$0.imageName == meme.imageName})
    }
}

extension MemesViewModel {

    func findAndOpenMemeByName(_ imageName: String) {
        guard let memeIndex = memes.firstIndex(where: {$0.imageName == imageName}) else { return }
        memeViewModel.loadMeme(memes[memeIndex])
    }

    func observeMemesState(_ closure: @escaping ([Meme]) -> Void) {
        self.observer = closure
        valueDidChange()
    }

    func observeSingleMeme(_ closure: @escaping (Meme) -> Void) {
        self.memeObserver = closure
        memeValueDidChange()
    }

    func returnMemesCount() -> Int {
        return memes.count
    }

    func findMeme(at index: Int) -> Meme {
        return memes[index]
    }

    func loadMeme(_ meme: Meme?) {
        memeViewModel.loadMeme(meme)
    }
}

extension MemesViewModel: MemeViewModelDelegate {

    func memeViewModel(_ viewModel: MemeViewModel, didLoadMeme state: Bool) {
        memeVCViewModel.updateIsImageLoaded(imageDidLoad: state)
    }

    func memeViewModel(_ viewModel: MemeViewModel, didChangeMeme meme: Meme) {
        if let index = findMemeIndex(meme) {
            memes[index] = meme
            self.index = index
        } else {
            memes.append(meme)
            self.index = memes.count - 1
        }
    }

    func memeViewModel(_ viewModel: MemeViewModel, didDeleteMeme meme: Meme) {
        guard let index = findMemeIndex(meme) else {return}
        memes.remove(at: index)
    }
}
