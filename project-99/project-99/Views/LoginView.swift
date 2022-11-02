//
//  LoginView.swift
//  project-99
//
//  Created by Patrick on 15.09.2022..
//

import UIKit
import Combine

class LoginView: UIView {
    private var warningLabel = UILabel()
    private var nameTextField = UITextField()
    private var passwordTextField = UITextField()
    private var loginButton = UIButton()
    private var createAccBtn = UIButton()
    private var loginStackView = UIStackView()
    private var textFieldsStackView = UIStackView()
    private var buttonsStackView = UIStackView()
    private var warningStackView = UIStackView()
    private var viewModel: LoginViewModel
    private var isLoggedIn: AnyCancellable?

    weak var delegate: LoginViewDelegate?

    init(with viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        setupBindings()

        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
            $0.passwordTextField.backgroundColor = $1.textFieldBackground
            $0.nameTextField.backgroundColor = $1.textFieldBackground
            $0.passwordTextField.textColor = $1.textColor
            $0.nameTextField.textColor = $1.textColor
            $0.reloadInputViews()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        isLoggedIn?.cancel()
    }
}

private extension LoginView {
    func setupUI() {

        self.addSubview(loginStackView)

        setupTextField(for: nameTextField)
        setupTextField(for: passwordTextField)

        loginButton.setupInView(self, withName: "Login", andAction: #selector(login))
        createAccBtn.setupInView(self, withName: "Create user", andAction: #selector(createUser))

        warningLabel.textColor = .red
        warningLabel.isHidden = true
        warningLabel.text = ""

        warningStackView.arrangeView(asColumnWithViews: [warningLabel], withSpacing: 20)
        textFieldsStackView.arrangeView(asColumnWithViews: [nameTextField, passwordTextField], withSpacing: 20)
        buttonsStackView.arrangeView(withButtons: [loginButton, createAccBtn])
        loginStackView.arrangeView(
            asColumnWithViews: [warningStackView, textFieldsStackView, buttonsStackView],
            withSpacing: 35)
        loginStackView.setupConstraints(self)
    }

    @objc func createUser() {
        self.nameTextField.endEditing(true)
        self.passwordTextField.endEditing(true)
        viewModel.createNewUser()
        self.nameTextField.text = ""
        self.passwordTextField.text = ""
        self.warningLabel.isHidden = true
    }

    @objc func login() {
        self.nameTextField.endEditing(true)
        self.passwordTextField.endEditing(true)
        viewModel.login()
        self.nameTextField.text = ""
        self.passwordTextField.text = ""
        self.warningLabel.isHidden = true
    }

    func setupTextField(for textField: UITextField ) {

        textField.setupInView()
        textField.delegate = self

        if textField == nameTextField {
            textField.placeholder = " Enter username..."
        } else {
            textField.placeholder = " Enter password..."
            textField.isSecureTextEntry = true
        }
    }

    func setupBindings() {

        isLoggedIn = viewModel.$loginSuccess
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] loginStatus in
                guard let self = self,
                      let loginStatus = loginStatus  else {return}
                if !loginStatus {
                    self.loginFailed()
                } else {
                    self.delegate?.loginView(self, didLogUser: self.viewModel.sendUser(), in: self.viewModel)
                }
            })
    }

    func loginFailed() {
        warningLabel.text = "! Incorrect user name and/or password"
        warningLabel.isHidden = false
    }
}

extension LoginView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.nameTextField.endEditing(true)
        self.passwordTextField.endEditing(true)
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField {
            viewModel.usernameChanged(textField.text ?? "")
        }

        if textField == passwordTextField {
            viewModel.passwordChanged(textField.text ?? "")
        }
    }
}
