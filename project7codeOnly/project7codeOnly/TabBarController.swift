//
//  TabBarController.swift
//  project7codeOnly
//
//  Created by Patrick on 06.06.2022..
//

import UIKit

class TabBarController: UITabBarController {

    let viewController = ListViewController(configuration: config1)
    let viewControllerTwo = ListViewController(configuration: config2)

    override func viewDidLoad() {
        super.viewDidLoad()

        configDelegate()

        let tabOne = viewController
        let tabOneBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        let tabTwo = viewControllerTwo
        let tabTwoBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 1 )

        tabOne.tabBarItem = tabOneBarItem
        tabTwo.tabBarItem = tabTwoBarItem

        self.setViewControllers([tabOne, tabTwo], animated: true)

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "a.magnify"),
            style: .plain,
            target: self,
            action: #selector(viewAPI))

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(filterItems))
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func configDelegate() {
        self.delegate = self
    }
}

extension TabBarController {

    @objc func viewAPI() {
        if selectedViewController?.tabBarItem.tag == 0 {
            viewController.viewAPI()
        } else {
            viewControllerTwo.viewAPI()
        }
    }

    @objc func filterItems() {
        if selectedViewController?.tabBarItem.tag == 0 {
            viewController.filterItems()
        } else {
            viewControllerTwo.filterItems()
        }
    }
}
