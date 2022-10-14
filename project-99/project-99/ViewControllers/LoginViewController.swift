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
    lazy var keyboardLayoutObserver: KeyboardLayoutObserver = {
        let keyboardLayoutObserver = KeyboardLayoutObserver(for: self)
        return keyboardLayoutObserver
    }()
    let keyboardLayoutGuide = UILayoutGuide()
    let realm: Realm

    init () {
        UserContainer.shared.saveUser(with: nil)
        self.realm = RealmDataProvider.shared.initiateRealm()
        self.viewModel = LoginViewModel(in: realm)
        self.loginView = LoginView(with: viewModel)
        super.init(nibName: nil, bundle: nil)
        ThemeManager.shared.currentTheme = ThemeContainer.shared.systemTheme
        self.keyboardLayoutObserver.delegate = self
        loginView.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        keyboardLayoutObserver.hideKeyboardOnTap(for: self)
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
        view.addSubview(loginView)
        view.addLayoutGuide(keyboardLayoutGuide)
        loginView.translatesAutoresizingMaskIntoConstraints = false
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

        let mainMenuViewModel = MainMenuViewModel(for: user, in: realm)
        let viewController = MainMenuViewController(with: mainMenuViewModel)
        viewController.delegate = self

        navigationController?.pushViewController(viewController, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: nil, action: nil)
    }
}

extension LoginViewController: KeyboardLayoutObserverDelegate {

    func keyboardLayoutObserver(_ layoutObserver: KeyboardLayoutObserver, didEndEditing editing: Bool) {
        self.view.endEditing(editing)
    }
}

extension LoginViewController: MainMenuViewControllerDelegate {
    func mainMenuViewController(
        _ viewController: MainMenuViewController,
        didReciveAccountDeletionFrom settingsViewController: SettingsViewController) {
            navigationController?.popViewController(animated: true)
            RealmDataService.shared.deleteAccount()
            viewModel.usernameChanged("")
            viewModel.passwordChanged("")
            viewModel.userDeleted()
        }
}
