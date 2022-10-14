//
//  ViewController.swift
//  project-99
//
//  Created by Patrick on 15.09.2022..
//

import UIKit
import RealmSwift
import Themes

class LoginViewController: UIViewController {

    let viewModel: LoginViewModel
    let loginView: LoginView
    lazy var keyboardController: KeyboardLayoutController = {
        let keyboardController = KeyboardLayoutController(for: self)
        return keyboardController
    }()

    let realm: Realm

    init () {
        UserContainer.shared.saveUser(with: nil)
        self.realm = RealmDataProvider.shared.initiateRealm()
        self.viewModel = LoginViewModel(in: realm)
        self.loginView = LoginView(with: viewModel)
        super.init(nibName: nil, bundle: nil)
        ThemeManager.shared.currentTheme = ThemeContainer.shared.systemTheme
        self.keyboardController.delegate = self
        loginView.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        keyboardController.hideKeyboardOnTap(for: self)
    }
}

private extension LoginViewController {
    func setupUI() {
        view.addSubview(loginView)
        loginView.frame = view.frame
    }
}

extension LoginViewController: LoginViewDelegate {
    func loginView(_ view: LoginView, didLogUser user: User, in viewModel: LoginViewModel) {

        let mainMenuViewModel = MainMenuViewModel(for: user, in: realm)
        let viewController = MainMenuViewController(with: mainMenuViewModel)

        navigationController?.pushViewController(viewController, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: nil, action: nil)
    }
}

extension LoginViewController: KeyboardControllerDelegate {
//    func keyboardController(_ controller: KeyboardLayoutController, didChangeConstraintValue constraint: Double, withDuration duration: Double?) {
//        viewModel.changeYConstraint(with: constraint)
//        if let duration = duration {
//
//            UIView.animate(withDuration: duration) {
//                self.view.layoutIfNeeded()
//            }
//        }
//    }

    func keyboardController(_ controller: KeyboardLayoutController, didEndEditing editing: Bool) {
        self.view.endEditing(editing)
    }
}
