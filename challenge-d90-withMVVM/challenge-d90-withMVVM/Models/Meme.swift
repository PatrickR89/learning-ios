//
//  Meme.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit
import RealmSwift

class Meme: Object {
    @Persisted(primaryKey: true) var imageName: String
    @Persisted var hasTopText: Bool
    @Persisted var hasBottomText: Bool
    convenience init(imageName: String, hasTopText: Bool, hasBottomText: Bool) {
        self.init()
        self.imageName = imageName
        self.hasTopText = hasTopText
        self.hasBottomText = hasBottomText
    }
}
