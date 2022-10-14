//
//  KeyboardControllerDelegate.swift
//  project-99
//
//  Created by Patrick on 14.10.2022..
//

import Foundation

protocol KeyboardControllerDelegate: AnyObject {
    func keyboardController(_ controller: KeyboardLayoutObserver, didEndEditing editing: Bool)
}
