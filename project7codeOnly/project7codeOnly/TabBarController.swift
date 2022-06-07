//
//  TabBarController.swift
//  project7codeOnly
//
//  Created by Patrick on 06.06.2022..
//

import UIKit

class TabBarController: UITabBarController {

    let viewController = ViewController()
    let viewControllerTwo = ViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        configDelegate()

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

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

    }
}

extension TabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let tabOne = viewController
        let tabOneBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)

        tabOne.tabBarItem = tabOneBarItem

        let tabTwo = viewControllerTwo
        let tabTwoBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 1 )

        tabTwo.tabBarItem = tabTwoBarItem

        self.setViewControllers([tabOne, tabTwo], animated: true)
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
