//
//  MemeVCViewModel.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

class MemeVCViewModel {
    private var isImageLoaded: Bool = false {
        didSet {
            valueDidChange()
        }
    }

    private var observer: ((Bool) -> Void)?

    private func valueDidChange() {
        guard let observer = self.observer else {return}
        observer(isImageLoaded)
    }
}

extension MemeVCViewModel {

    func observeImageState(_ closure: @escaping (Bool) -> Void) {
        self.observer = closure
        valueDidChange()
    }

    func updateIsImageLoaded(imageDidLoad isImageLoaded: Bool) {
        self.isImageLoaded = isImageLoaded
    }
}
