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
    }

    private func setupUI() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NewGameViewCell.dequeue(in: tableView, for: indexPath)
        cell.setupLevelLabel(with: viewModel.loadLevel(at: indexPath.row))
        return cell
    }
}

extension NewGameViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navController = UINavigationController()
        let gameViewModel = GameVCViewModel(for: viewModel.loadLevel(at: indexPath.row))
        let viewController = GameViewController(with: gameViewModel)

        navController.viewControllers = [viewController]
        present(navController, animated: true)
    }
}
