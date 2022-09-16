//
//  LoginView.swift
//  project-99
//
//  Created by Patrick on 15.09.2022..
//

import UIKit

class LoginView: UIView {
    var nameView = UITextView()
    var passwordView = UITextView()
    var loginButton = UIButton()
    var createAccBtn = UIButton()

    init(with viewModel: LoginViewModel) {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LoginView {
    func setupUI() {
        self.addSubview(nameView)
        self.addSubview(passwordView)
        self.addSubview(loginButton)
        self.addSubview(createAccBtn)
        self.backgroundColor = .white

        nameView.translatesAutoresizingMaskIntoConstraints = false
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        createAccBtn.translatesAutoresizingMaskIntoConstraints = false

        nameView.text = "Enter username..."
        nameView.textContainer.maximumNumberOfLines = 1
        nameView.textAlignment = .left
        nameView.backgroundColor = .lightGray
        nameView.textColor = .black
        nameView.layer.borderColor = UIColor.white.cgColor
        nameView.layer.borderWidth = 1
        passwordView.text = "Enter password..."
        passwordView.textContainer.maximumNumberOfLines = 1
        passwordView.textAlignment = .left
        passwordView.backgroundColor = .lightGray
        passwordView.textColor = .black

        loginButton.setTitle("Login", for: .normal)
        createAccBtn.setTitle("Create user", for: .normal)

        loginButton.backgroundColor = .systemBlue
        createAccBtn.backgroundColor = .systemBlue

        NSLayoutConstraint.activate([
            nameView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50),
            nameView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            nameView.heightAnchor.constraint(equalToConstant: 35),
            passwordView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 20),
            passwordView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordView.widthAnchor.constraint(equalTo: nameView.widthAnchor),
            passwordView.heightAnchor.constraint(equalToConstant: 35),
            loginButton.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 40),
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: nameView.widthAnchor),
            createAccBtn.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            createAccBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            createAccBtn.widthAnchor.constraint(equalTo: nameView.widthAnchor)
        ])
    }
}
