//
//  Levels.swift
//  project-99
//
//  Created by Patrick on 15.09.2022..
//

import UIKit
import RealmSwift

enum Levels: String, PersistableEnum {
    case VeryEasy = "2 * 4"
    case Easy = "3 * 4"
    case Medium = "4 * 4"
    case Hard = "3 * 6"
    case VeryHard = "4 * 6"
    case EmotionalDamage = "4 * 8"
}
