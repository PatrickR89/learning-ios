//
//  Level.swift
//  project-99
//
//  Created by Patrick on 15.09.2022..
//

import UIKit
import RealmSwift

enum Level: String, PersistableEnum {
    case veryEasy = "2*4"
    case easy = "3*4"
    case mediumHard = "4*4"
    case hard = "3*6"
    case veryHard = "4*6"
    case emotionalDamage = "4*8"
}
