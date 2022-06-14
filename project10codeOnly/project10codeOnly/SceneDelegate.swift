//
//  SceneDelegate.swift
//  project10codeOnly
//
//  Created by Patrick on 14.06.2022..
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene: UIWindowScene = (scene as? UIWindowScene) else {return}
            let navController = UINavigationController()
            let viewController = ViewController()

            navController.viewControllers = [viewController]

            window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window?.windowScene = windowScene
            window?.rootViewController = navController
            window?.makeKeyAndVisible()
    }
}
