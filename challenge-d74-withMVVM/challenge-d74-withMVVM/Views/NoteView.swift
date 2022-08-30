//
//  NoteView.swift
//  challenge-d74-withMVVM
//
//  Created by Patrick on 23.08.2022..
//

import UIKit

class NoteView: UIView {

    private let titleView = UITextField()
    private let contentView = UITextView()
    private let button = UIButton()

    weak var delegate: NoteViewDelegate?

    init(with viewModel: NoteViewModel, btnTitle: String) {
        self.titleView.text = viewModel.noteTitle
        self.contentView.text = viewModel.noteContent
        self.button.setTitle(btnTitle, for: .normal)

        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NoteView {
    func setupUI() {
        self.backgroundColor = .white
        self.addSubview(titleView)
        self.addSubview(contentView)
        self.addSubview(button)

        titleView.delegate = self
        contentView.delegate = self

        titleView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        titleView.font = .preferredFont(forTextStyle: .title2)
        contentView.font = .preferredFont(forTextStyle: .body)

        titleView.layer.borderColor = UIColor.lightGray.cgColor
        titleView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1

        button.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)

        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            titleView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75),
            contentView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 15),
            contentView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75),
            contentView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            contentView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.7),
            button.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 15),
            button.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            button.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7)
        ])
    }

    @objc func buttonTouched() {
        delegate?.noteViewDidTapButton()
    }
}

extension NoteView {
    func toggleButton(_ isEnabled: Bool) {
        if isEnabled {
            button.backgroundColor = .systemBlue
        } else {
            button.backgroundColor = .lightGray
        }
        button.isEnabled = isEnabled
    }
}

extension NoteView: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        guard let text = textView.text else {return}
        delegate?.noteView(self, didUpdateContent: text)
    }
}

extension NoteView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {return}
        delegate?.noteView(self, didUpdateTitle: text)
    }
}
