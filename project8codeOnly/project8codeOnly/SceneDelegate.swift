//
//  SceneDelegate.swift
//  project8codeOnly
//
//  Created by Patrick on 08.06.2022..
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene: UIWindowScene = (scene as? UIWindowScene) else {return}
            let viewController = ViewController()

            window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window?.windowScene = windowScene
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
    }
}
