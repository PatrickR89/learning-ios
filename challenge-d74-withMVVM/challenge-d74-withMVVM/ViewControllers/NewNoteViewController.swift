//
//  NewNoteViewController.swift
//  challenge-d74-withMVVM
//
//  Created by Patrick on 23.08.2022..
//

import UIKit

class NewNoteViewController: UIViewController {

    var noteView = NoteView(title: "", content: "", btnTitle: "ADD")

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "CLOSE",
            style: .plain,
            target: self,
            action: #selector(closeSelf))

        setupUI()
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
}
extension NewNoteViewController: NoteViewDelegate {
    func titleUpdate(_ title: String) {
        print(title)
    }

    func contentUpdated(_ content: String) {
        print(content)
    }

    func buttonClicked() {
        print("click")
    }
}
