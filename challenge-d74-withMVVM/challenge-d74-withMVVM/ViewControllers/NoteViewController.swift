//
//  NoteViewController.swift
//  challenge-d74-withMVVM
//
//  Created by Patrick on 30.08.2022..
//

import UIKit

class NoteViewController: UIViewController {

    private let noteView: NoteView
    private let viewModel: NoteViewModel

    init(with viewModel: NoteViewModel) {

        self.viewModel = viewModel
        self.noteView = NoteView(with: viewModel)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        view.backgroundColor = .white

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "CLOSE",
            style: .plain,
            target: self,
            action: #selector(closeSelf))
    }
}

private extension NoteViewController {
    @objc func closeSelf() {
        self.dismiss(animated: true)
    }

    func setupUI() {
        view.addSubview(noteView)
        noteView.delegate = self
        noteView.frame = view.bounds
    }

    func setupBindings() {
        viewModel.isButtonEnabled.bind { [weak self] isEnabled in
            guard let isEnabled = isEnabled else {return}
            self?.noteView.toggleButton(isEnabled)
        }

        viewModel.buttonTitle.bind { [weak self] title in
            guard let title = title else {return}
            self?.noteView.setupButtonTitle(title: title)
        }
    }
}

extension NoteViewController: NoteViewDelegate {
    func noteView(_ view: NoteView, didUpdateTitle title: String) {
        viewModel.noteTitle = title
    }

    func noteView(_ view: NoteView, didUpdateContent content: String) {
        viewModel.noteContent = content
    }

    func noteViewDidTapButton() {
        viewModel.applyChanges()
        self.dismiss(animated: true)
    }
}
