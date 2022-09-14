//
//  MemesViewModel.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit
import RealmSwift

class MemesViewModel {

    var realm: Realm
    var memes: Results<Meme>

    private var index: Int? {
        didSet {
            memeValueDidChange()
        }
    }

    private var observer: (([Meme]) -> Void)?
    private var memeObserver: ((Meme) -> Void)?

    let memeViewModel = MemeViewModel()
    let memeVCViewModel = MemeVCViewModel()

    init(realm: Realm) {
        self.realm = realm
        self.memes = realm.objects(Meme.self).sorted(byKeyPath: "dateAdded", ascending: false)
        memeViewModel.delegate = self
        memeViewModel.appendMemeVCViewModel(memeVCViewModel)
    }
}

private extension MemesViewModel {

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
        if let imageName = meme?.imageName {
            memeVCViewModel.imageNameLoaded(imageName: imageName)
        }
    }
}

extension MemesViewModel: MemeViewModelDelegate {
    func memeViewModel(_ viewModel: MemeViewModel, didLoadMeme state: Bool) {
        memeVCViewModel.updateIsImageLoaded(imageDidLoad: state)
    }

    func memeViewModel(_ viewModel: MemeViewModel, didEnableEditing state: Bool) {
        memeVCViewModel.updateEditState(editIsEnabled: state)
    }

    func memeViewModel(_ viewModel: MemeViewModel, didChangeMeme inputMeme: Meme) {
        if let index = findMemeIndex(inputMeme) {
            let meme = memes[index]

            try? self.realm.write {
                if !meme.hasTopText {
                    meme.hasTopText = memeViewModel.topText.value != ""
                }
                if !meme.hasBottomText {
                    meme.hasBottomText = memeViewModel.bottomText.value != ""
                }
            }
            self.index = index
        } else {
            try? self.realm.write {
                self.realm.add(inputMeme)
            }
            self.index = memes.count - 1
        }
    }

    func memeViewModel(_ viewModel: MemeViewModel, didDeleteMeme meme: Meme) {
        guard let index = findMemeIndex(meme) else {return}
        let meme = memes[index]
        try? realm.write {
            realm.delete(meme)
        }
    }
}
