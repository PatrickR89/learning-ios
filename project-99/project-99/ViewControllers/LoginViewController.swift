//
//  ViewController.swift
//  project-99
//
//  Created by Patrick on 15.09.2022..
//

import UIKit
import Themes

class LoginViewController: UIViewController {

    let viewModel: LoginViewModel
    let loginView: LoginView
    let keyboardLayoutObserver = KeyboardLayoutObserver()

    weak var delegate: LoginViewControllerDelegate?

    let keyboardLayoutGuide = UILayoutGuide()

    init () {
        UserContainer.shared.saveUser(with: nil)
        self.viewModel = LoginViewModel()
        self.loginView = LoginView(with: viewModel)
        super.init(nibName: nil, bundle: nil)
        keyboardLayoutObserver.enableKeyboardObserver(for: self)
        ThemeManager.shared.currentTheme = ThemeContainer.shared.systemTheme
        loginView.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func keyboardDidUpdate(with height: Double, for duration: Double) {
        let constraint = self.keyboardLayoutGuide
            .constraintsAffectingLayout(for: .vertical)
            .first {
                $0.firstAttribute == .height
            }

        constraint?.constant = height

        self.view.layoutIfNeeded()
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: .allowAnimatedContent,
            animations: {
                self.view.layoutIfNeeded()
            }
        )
    }
}

private extension LoginViewController {
    func setupUI() {
        view.addViews([loginView])
        view.addLayoutGuide(keyboardLayoutGuide)
        NSLayoutConstraint.activate([
            keyboardLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            keyboardLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardLayoutGuide.heightAnchor.constraint(equalToConstant: 0),
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.widthAnchor.constraint(equalTo: view.widthAnchor),
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor)
        ])
    }
}

extension LoginViewController: LoginViewDelegate {
    func loginView(_ view: LoginView, didLogUser user: User, in viewModel: LoginViewModel) {

        let mainMenuViewModel = MainMenuViewModel(for: user)
        delegate?.loginViewController(self, didLogUserInViewModel: mainMenuViewModel)
    }
}
