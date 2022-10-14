//
//  KeyboardControllerDelegate.swift
//  project-99
//
//  Created by Patrick on 14.10.2022..
//

import Foundation

protocol KeyboardLayoutObserverDelegate: AnyObject {
    func keyboardLayoutObserver(_ layoutObserver: KeyboardLayoutObserver, didEndEditing editing: Bool)
}
