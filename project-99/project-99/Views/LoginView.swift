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
    private var viewModel: LoginViewModel

    init(with viewModel: LoginViewModel) {
        self.viewModel = viewModel
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

        setupTextView(for: nameView)
        setupTextView(for: passwordView)

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

    private func setupTextView(for textView: UITextView) {
        textView.textContainer.maximumNumberOfLines = 1
        textView.textAlignment = .left
        textView.backgroundColor = .lightGray
        textView.textColor = .black
        textView.isScrollEnabled = false
        textView.delegate = self

        if textView == nameView {
            nameView.text = "Enter username..."
        } else {
            passwordView.text = "Enter password..."
        }
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
