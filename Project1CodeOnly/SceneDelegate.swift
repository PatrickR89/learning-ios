//
//  SceneDelegate.swift
//  Project1CodeOnly
//
//  Created by Patrick on 23.05.2022..
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else {return}
        let navController = NavigationController()
        let viewController = ViewController()
        navController.viewControllers = [viewController]
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        guard let _ = (scene as? UIWindowScene) else { return }
    }
}
