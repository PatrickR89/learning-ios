//
//  KeyboardLayoutObserver.swift
//  project-99
//
//  Created by Patrick on 14.10.2022..
//

import UIKit
import Combine

class KeyboardLayoutObserver {

    private var cancellables: Set<AnyCancellable> = []

    init(for viewController: LoginViewController) {
        enableKeyboardObserver(for: viewController)
    }

    func enableKeyboardObserver(for viewController: LoginViewController) {

        NotificationCenter.default.publisher(
            for: UIApplication.keyboardWillShowNotification)
        .sink(receiveValue: { notification in

            guard let rect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
                  let duration = notification
                    .userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
                return
            }
            viewController.keyboardDidUpdate(with: rect.height, for: duration)

        }).store(in: &cancellables)

        NotificationCenter.default.publisher(
            for: UIApplication.keyboardWillHideNotification)
        .sink(receiveValue: { notification in

            guard let duration = notification
                    .userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
                return
            }
            viewController.keyboardDidUpdate(with: 0, for: duration)

        }).store(in: &cancellables)
    }
}
