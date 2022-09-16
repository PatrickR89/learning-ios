//
//  LoginView.swift
//  project-99
//
//  Created by Patrick on 15.09.2022..
//

import UIKit

class LoginView: UIView {
    private var warningLabel = UILabel()
    private var nameView = UITextView()
    private var passwordView = UITextView()
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
        let subviews = [nameView, passwordView, loginButton, createAccBtn, warningLabel]
        for subview in subviews {
            self.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }

        self.backgroundColor = .white

        setupTextView(for: nameView)
        setupTextView(for: passwordView)

        loginButton.setTitle("Login", for: .normal)
        createAccBtn.setTitle("Create user", for: .normal)

        createAccBtn.addTarget(self, action: #selector(createUser), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)

        loginButton.backgroundColor = .systemBlue
        createAccBtn.backgroundColor = .systemBlue

        warningLabel.textColor = .red
        warningLabel.isHidden = true
        warningLabel.text = ""

        activateConstraints()
    }

    func activateConstraints() {
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
            createAccBtn.widthAnchor.constraint(equalTo: nameView.widthAnchor),
            warningLabel.bottomAnchor.constraint(equalTo: nameView.topAnchor, constant: -30),
            warningLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            warningLabel.widthAnchor.constraint(equalTo: nameView.widthAnchor),
            warningLabel.heightAnchor.constraint(equalTo: nameView.heightAnchor)
        ])
    }

    @objc func createUser() {
        self.nameView.endEditing(true)
        self.passwordView.endEditing(true)
        viewModel.createNewUser()
    }

    @objc func login() {
        self.nameView.endEditing(true)
        self.passwordView.endEditing(true)
        viewModel.login()
    }

    func setupTextView(for textView: UITextView) {
        textView.textContainer.maximumNumberOfLines = 1
        textView.textAlignment = .left
        textView.backgroundColor = .lightGray
        textView.textColor = .black
        textView.isScrollEnabled = false
        textView.delegate = self
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none

        if textView == nameView {
            nameView.text = "Enter username..."
        } else {
            passwordView.text = "Enter password..."
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
        self.nameView.endEditing(true)
        self.passwordView.endEditing(true)
    }
}

extension LoginView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == nameView {
            if textView.text == "Enter username..." {
                textView.text = ""
            }
        }

        if textView == passwordView {
            if textView.text == "Enter password..." {
                textView.text = ""
            }
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == nameView {
            if textView.text == "" {
                textView.text = "Enter username..."
            } else {
                viewModel.usernameChanged(textView.text)
            }
        }

        if textView == passwordView {
            if textView.text == "" {
                textView.text = "Enter password..."
            } else {
                viewModel.passwordChanged(textView.text)
            }
        }
    }
}
