//
//  ViewController.swift
//  challenge-d74-withMVVM
//
//  Created by Patrick on 23.08.2022..
//

import UIKit

class NotesListViewController: UITableViewController {

    private let viewModel = NotesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(openNewNoteViewController))
    }
}

extension NotesListViewController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return viewModel.notes.value?.count ?? 0
        }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "NoteCell",
                for: indexPath) as? NoteTableViewCell else {fatalError("No cell found")}
            let title = viewModel.notes.value?[indexPath.row].title ?? "No note"
            cell.setupCell(title)
            return cell
        }

    override func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            var actions = [UIContextualAction]()
            let deleteNote = UIContextualAction(style: .normal, title: "DELETE") { [weak self] _, _, completitionHandler in
                self?.viewModel.deleteNote(indexPath.row)
                completitionHandler(true)
            }
            actions.append(deleteNote)
            let swipeConfig = UISwipeActionsConfiguration(actions: actions)
            swipeConfig.performsFirstActionWithFullSwipe = false

            return swipeConfig
        }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navController = UINavigationController()

        viewModel.loadNote(index: indexPath.row)
        let viewController = NoteViewController(
            with: viewModel.noteViewModel)

        navController.viewControllers = [viewController]
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
}

private extension NotesListViewController {
    func setupUI() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = view.bounds
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "NoteCell")
    }

    func setupBindings() {
        viewModel.notes.bind { [weak self] notes in
            self?.tableView.reloadData()
            guard let notes = notes else {return}
            DataStorage.shared.encodeAndSave(notes)
        }
    }

    @objc func openNewNoteViewController() {
        let navController = UINavigationController()
        viewModel.loadNote(index: nil)
        let viewController = NoteViewController(with: viewModel.noteViewModel)
        navController.modalPresentationStyle = .fullScreen
        navController.viewControllers = [viewController]
        present(navController, animated: true)
    }
}
