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
    lazy var tableViewDataSource: UITableViewDiffableDataSource<NewGameTableViewSections, NewGameTableViewItems> = {
        let tableViewDataSource =
        UITableViewDiffableDataSource<
            NewGameTableViewSections, NewGameTableViewItems
        >(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = NewGameCell.dequeue(in: tableView, for: indexPath)

            switch itemIdentifier {
            case .game(let model):
                cell.updateCellData(with: model)
            }
            return cell
        }
        return tableViewDataSource
    }()

    weak var delegate: NewGameViewControllerDelegate?

    init() {
        super.init(nibName: nil, bundle: nil)

        use(AppTheme.self) {
            $0.view.backgroundColor = $1.backgroundColor
            $0.tableView.backgroundColor = $1.backgroundColor
            $0.navigationItem.leftBarButtonItem?.tintColor = $1.textColor
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
            image: UIImage(systemName: "xmark.circle"),
            style: .plain,
            target: self,
            action: #selector(dismissSelf))
    }

    @objc private func dismissSelf() {
        delegate?.newGameViewControllerDidRequestDismiss(self)
    }

    private func setupUI() {
        view.appendViews([tableView])
        tableView.delegate = self
        NewGameCell.register(in: tableView)
        reloadData()

        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }

    func reloadData() {
        var gameOptions = [NewGameTableViewItems]()
        Level.allCases.forEach {
            gameOptions.append(NewGameTableViewItems.game(NewGameCellModel($0)))
        }

        var snapshot = NSDiffableDataSourceSnapshot<NewGameTableViewSections, NewGameTableViewItems>()
        snapshot.appendSections([.main])
        snapshot.appendItems(gameOptions, toSection: .main)
        tableViewDataSource.apply(snapshot)
    }
}

extension NewGameViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let stopwatch = Stopwatch()
        let gameViewModel = GameVCViewModel(for: viewModel.loadLevel(at: indexPath.row), with: stopwatch)

        delegate?.newGameViewController(self, didStartNewGameWithViewModel: gameViewModel, and: stopwatch)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
