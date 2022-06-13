//
//  ListViewControllerConfig.swift
//  project7codeOnly
//
//  Created by Patrick on 09.06.2022..
//

import Foundation
import UIKit

struct ListViewControllerConfig {
    let url: String
    let cellBackgroundColor: UIColor
}

let config1 = ListViewControllerConfig(
    url: "https://www.hackingwithswift.com/samples/petitions-1.json",
    cellBackgroundColor: .gray)

let config2 = ListViewControllerConfig(
    url: "https://www.hackingwithswift.com/samples/petitions-2.json",
    cellBackgroundColor: .lightGray)
