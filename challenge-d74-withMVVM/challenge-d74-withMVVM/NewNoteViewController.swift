//
//  NewNoteViewController.swift
//  challenge-d74-withMVVM
//
//  Created by Patrick on 23.08.2022..
//

import UIKit

class NewNoteViewController: UIViewController {

    var newView = NoteView(title: "", content: "", btnTitle: "ADD")

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
        view.addSubview(newView)
        newView.frame = view.bounds
    }
}
