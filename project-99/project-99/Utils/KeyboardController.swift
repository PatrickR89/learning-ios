//
//  KeyboardLayoutController.swift
//  project-99
//
//  Created by Patrick on 14.10.2022..
//

import UIKit
import Combine

enum KeyboardStatus {
    case hidden
    case shown
}

class KeyboardLayoutController {

    @Published private(set) var keyboardStatus: KeyboardStatus = .hidden {
        didSet {
            print(keyboardStatus)
        }
    }

    private var cancellables: Set<AnyCancellable> = []

    weak var delegate: KeyboardControllerDelegate?

    init(for viewController: LoginViewController) {
        enableKeyboardObserver(for: viewController)
    }

    func hideKeyboardOnTap(for viewController: UIViewController) {

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardOnTap))
        tap.cancelsTouchesInView = false
        viewController.view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboardOnTap() {
        delegate?.keyboardController(self, didEndEditing: true)
    }

    func enableKeyboardObserver(for viewController: LoginViewController) {

        NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification).sink(receiveValue: { _ in
            self.keyboardStatus = .shown
        }).store(in: &cancellables)

        NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification).sink(receiveValue: { _ in
            self.keyboardStatus = .hidden
        }).store(in: &cancellables)
    }
}
