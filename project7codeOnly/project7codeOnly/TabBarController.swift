//
//  TabBarController.swift
//  project7codeOnly
//
//  Created by Patrick on 06.06.2022..
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configDelegate()
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func configDelegate() {
        self.delegate = self
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("test")
    }
}

extension TabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let navController = UINavigationController()
        let viewController = ViewController()
        navController.viewControllers = [viewController]

        let tabOne = navController
        let tabOneBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)

        tabOne.tabBarItem = tabOneBarItem

        self.viewControllers = [tabOne]
    }
}
