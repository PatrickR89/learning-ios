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

    private func valueDidChange() {
        guard let observer = observer else {
            return
        }
        observer(memes)
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
}
