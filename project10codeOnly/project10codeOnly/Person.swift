//
//  Person.swift
//  project10codeOnly
//
//  Created by Patrick on 14.06.2022..
//

import UIKit

struct Person: Codable {

    var name: String
    var image: String

    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
