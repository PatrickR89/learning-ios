//
//  GameViewCellViewModel.swift
//  project-99
//
//  Created by Patrick on 19.10.2022..
//

import UIKit
import Combine

class GameViewCellViewModel {
    @Published private(set) var image: UIImage?

    func setupImageName(_ name: String) {
        self.image = UIImage(systemName: name)
    }

    func removeImage() {
        self.image = nil
    }
}
