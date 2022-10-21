//
//  NewGameViewController.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import UIKit

class NewGameViewController: UIViewController {

    private let viewModel = NewGameViewModel()
    private let tableView = UITableView()

    init() {
        super.init(nibName: nil, bundle: nil)

        use(AppTheme.self) {
            $0.view.backgroundColor = $1.backgroundColor
            $0.tableView.backgroundColor = $1.backgroundColor
            $0.tableView.reloadData()
            $0.reloadInputViews()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(dismissSelf))
    }

    @objc private func dismissSelf() {
        self.dismiss(animated: true)
    }

    private func setupUI() {
        view.addViews([tableView])
        tableView.dataSource = self
        tableView.delegate = self
        NewGameViewCell.register(in: tableView)

        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
}

extension NewGameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countLevels()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NewGameViewCell.dequeue(in: tableView, for: indexPath)
        cell.setupLevelLabelText(with: viewModel.loadLevel(at: indexPath.row))
        return cell
    }
}

extension NewGameViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navController = UINavigationController()
        let stopwatch = Stopwatch()
        let gameViewModel = GameVCViewModel(for: viewModel.loadLevel(at: indexPath.row), with: stopwatch)
        let viewController = GameViewController(with: gameViewModel, and: stopwatch)

        navController.viewControllers = [viewController]
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
}
