//
//  Coordinator.swift
//  project-99
//
//  Created by Patrick on 04.11.2022..
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] {get set}
    var navController: UINavigationController {get set}

    func start(animated: Bool)
    func startAsChild(user: User)
}

extension Coordinator {
    func start(animated: Bool) {}
    func startAsChild(user: User) {}
}
