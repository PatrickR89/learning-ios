//
//  ViewController.swift
//  challenge-d74-withMVVM
//
//  Created by Patrick on 23.08.2022..
//

import UIKit

class NotesListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(openNewNoteViewController))
    }
}

extension NotesListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "NoteCell",
            for: indexPath) as? NoteTableViewCell else {fatalError("No cell found")}
        cell.setupCell("this is a cell")
        return cell
    }
}

private extension NotesListViewController {
    func setupUI() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = view.bounds
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "NoteCell")
    }

    @objc func openNewNoteViewController() {
        let navController = UINavigationController()
        let viewController = NewNoteViewController()
        navController.modalPresentationStyle = .fullScreen
        navController.viewControllers = [viewController]
        present(navController, animated: true)
    }
}
