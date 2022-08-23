//
//  NewNoteViewController.swift
//  challenge-d74-withMVVM
//
//  Created by Patrick on 23.08.2022..
//

import UIKit

class NewNoteViewController: UIViewController {

    var noteView = NoteView(title: "", content: "", btnTitle: "ADD")
    var viewModel = NoteViewModel(note: Note(title: "", content: ""), newNote: true, index: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "CLOSE",
            style: .plain,
            target: self,
            action: #selector(closeSelf))

        setupUI()
        setupBindings()
    }
}

private extension NewNoteViewController {
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
extension NewNoteViewController: NoteViewDelegate {
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
