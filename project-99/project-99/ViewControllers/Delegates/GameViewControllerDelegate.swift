//
//  GameViewControllerDelegate.swift
//  project-99
//
//  Created by Patrick on 27.10.2022..
//

import Foundation

protocol GameViewControllerDelegate: AnyObject {
    func gameViewControllerDidRequestDismiss(_ viewController: GameViewController)
}
