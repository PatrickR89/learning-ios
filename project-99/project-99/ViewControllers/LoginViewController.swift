//
//  ViewController.swift
//  project-99
//
//  Created by Patrick on 15.09.2022..
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController {

    let viewModel = LoginViewModel()
    let loginView: LoginView

    init () {
        self.loginView = LoginView(with: viewModel)
        super.init(nibName: nil, bundle: nil)
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
