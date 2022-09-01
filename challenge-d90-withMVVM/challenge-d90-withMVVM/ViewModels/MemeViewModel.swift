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
        }
    }

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
}
