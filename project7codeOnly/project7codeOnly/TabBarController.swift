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
        print("test \(tabBar.tag)")
    }
}

extension TabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let viewController = ViewController()
        let viewControllerTwo = ViewController()

        let tabOne = viewController
        let tabOneBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)

        tabOne.tabBarItem = tabOneBarItem

        let tabTwo = viewControllerTwo
        let tabTwoBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 1 )

        tabTwo.tabBarItem = tabTwoBarItem

        self.setViewControllers([tabOne, tabTwo], animated: true)
    }
}
