//
//  EditNoteViewController.swift
//  challenge-d74-withMVVM
//
//  Created by Patrick on 23.08.2022..
//

import UIKit

class EditNoteViewController: UIViewController {

    let noteView: NoteView
    let viewModel: NoteViewModel

    init(note: Note, index: Int) {
        self.noteView = NoteView(title: note.title, content: note.content, btnTitle: "APPLY")
        self.viewModel = NoteViewModel(note: note, newNote: false, index: index)

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

private extension EditNoteViewController {
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
    }
}

extension EditNoteViewController: NoteViewDelegate {
    func titleUpdate(_ title: String) {
        viewModel.noteTitle = title
    }

    func contentUpdated(_ content: String) {
        viewModel.noteContent = content
    }

    func buttonClicked() {
        viewModel.applyChanges()
        self.dismiss(animated: true)
    }
}
