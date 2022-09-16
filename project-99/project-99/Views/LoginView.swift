//
//  LoginView.swift
//  project-99
//
//  Created by Patrick on 15.09.2022..
//

import UIKit

class LoginView: UIView {
    private var warningLabel = UILabel()
    private var nameField = UITextField()
    private var passwordField = UITextField()
    private var loginButton = UIButton()
    private var createAccBtn = UIButton()
    private var viewModel: LoginViewModel

    init(with viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LoginView {
    func setupUI() {
        let subviews = [nameField, passwordField, loginButton, createAccBtn, warningLabel]
        for subview in subviews {
            self.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }

        self.backgroundColor = .white

        setupTextView(for: nameField)
        setupTextView(for: passwordField)

        loginButton.setTitle("Login", for: .normal)
        createAccBtn.setTitle("Create user", for: .normal)

        createAccBtn.addTarget(self, action: #selector(createUser), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)

        loginButton.backgroundColor = .systemBlue
        createAccBtn.backgroundColor = .systemBlue

        loginButton.layer.cornerRadius = 4
        createAccBtn.layer.cornerRadius = 4

        warningLabel.textColor = .red
        warningLabel.isHidden = true
        warningLabel.text = ""

        activateConstraints()
    }

    func activateConstraints() {
        NSLayoutConstraint.activate([
            nameField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50),
            nameField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            nameField.heightAnchor.constraint(equalToConstant: 35),
            passwordField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            passwordField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordField.widthAnchor.constraint(equalTo: nameField.widthAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 35),
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 40),
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: nameField.widthAnchor),
            createAccBtn.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            createAccBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            createAccBtn.widthAnchor.constraint(equalTo: nameField.widthAnchor),
            warningLabel.bottomAnchor.constraint(equalTo: nameField.topAnchor, constant: -30),
            warningLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            warningLabel.widthAnchor.constraint(equalTo: nameField.widthAnchor),
            warningLabel.heightAnchor.constraint(equalTo: nameField.heightAnchor)
        ])
    }

    @objc func createUser() {
        self.nameField.endEditing(true)
        self.passwordField.endEditing(true)
        viewModel.createNewUser()
    }

    @objc func login() {
        self.nameField.endEditing(true)
        self.passwordField.endEditing(true)
        viewModel.login()
    }

    func setupTextView(for textField: UITextField ) {

        textField.textAlignment = .left
        textField.textColor = .black
        textField.delegate = self
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor

        if textField == nameField {
            textField.placeholder = " Enter username..."
        } else {
            textField.placeholder = " Enter password..."
            textField.isSecureTextEntry = true
        }
    }

    func setupBindings() {
        viewModel.observeLoginStatus { loginStatus in
            DispatchQueue.main.async { [weak self] in
                if !loginStatus {
                    self?.loginFailed()
                }
            }
        }
    }

    func loginFailed() {
        warningLabel.text = "! Incorrect user name and/or password"
        warningLabel.isHidden = false
    }
}

extension LoginView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.nameField.endEditing(true)
        self.passwordField.endEditing(true)
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameField {
            viewModel.usernameChanged(textField.text ?? "")
        }

        if textField == passwordField {
            viewModel.passwordChanged(textField.text ?? "")
        }
    }
}
