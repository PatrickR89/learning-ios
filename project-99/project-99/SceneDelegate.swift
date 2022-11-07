//
//  SceneDelegate.swift
//  project-99
//
//  Created by Patrick on 15.09.2022..
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: MainCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {

            guard let windowScene: UIWindowScene = (scene as? UIWindowScene) else {return}
            let navController = UINavigationController()
            mainCoordinator = MainCoordinator(navController)
            mainCoordinator?.start(animated: false)
            window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window?.windowScene = windowScene
            window?.rootViewController = navController
            window?.makeKeyAndVisible()
        }
}
