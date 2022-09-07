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
    @Persisted var dateAdded: Date
    convenience init(imageName: String, hasTopText: Bool, hasBottomText: Bool, dateAdded: Date) {
        self.init()
        self.imageName = imageName
        self.hasTopText = hasTopText
        self.hasBottomText = hasBottomText
        self.dateAdded = dateAdded
    }
}
