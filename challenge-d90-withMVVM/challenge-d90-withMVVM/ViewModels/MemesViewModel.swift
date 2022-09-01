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

    private var observer: (([Meme]) -> Void)?

    let memeViewModel = MemeViewModel()
    let memeVCViewModel = MemeVCViewModel()

    init() {
        memeViewModel.delegate = self
    }
}

private extension MemesViewModel {
    func valueDidChange() {
        guard let observer = observer else {
            return
        }
        observer(memes)
    }

    func findMemeInSelf(_ meme: Meme) -> Int? {
        return memes.firstIndex(where: {$0.image == meme.image})
    }
}

extension MemesViewModel {

    func observeMemesState(_ closure: @escaping ([Meme]) -> Void) {
        self.observer = closure
        valueDidChange()
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
        if let index = findMemeInSelf(meme) {
            memes[index] = meme
        } else {
            memes.append(meme)
        }
    }

    func memeViewModel(_ viewModel: MemeViewModel, didDeleteMeme meme: Meme) {
        guard let index = findMemeInSelf(meme) else {return}
        memes.remove(at: index)
    }
}
