//
//  ViewController.swift
//  project-99
//
//  Created by Patrick on 15.09.2022..
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController {

    let viewModel: LoginViewModel
    let loginView: LoginView
    let realm: Realm

    init () {
        self.realm = RealmDataService.shared.initiateRealm()
        self.viewModel = LoginViewModel(in: realm)
        self.loginView = LoginView(with: viewModel)
        super.init(nibName: nil, bundle: nil)
        loginView.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
