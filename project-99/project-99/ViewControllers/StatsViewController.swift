//
//  StatsViewController.swift
//  project-99
//
//  Created by Patrick on 20.09.2022..
//

import UIKit

class StatsViewController: UIViewController {

    private let viewModel: StatsViewModel
    private let tableView = UITableView()
    private let content: [StatsContent] = [.games, .pairs, .gameTimes]

    init(with viewModel: StatsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
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
        view.addSubview(tableView)
        GamesViewCell.register(in: tableView)
        PairsViewCell.register(in: tableView)
        TimesViewCell.register(in: tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, constant: -50),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}

extension StatsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.isCellBottomHidden[indexPath.row] {
            return 40
        } else {
            if (tableView.cellForRow(at: indexPath) as? TimesViewCell) != nil {
                return 350
            } else {
                return 180
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellContent = content[indexPath.row]
        switch cellContent {
        case .games:
            let cell = GamesViewCell.dequeue(in: tableView, for: indexPath)
            cell.bottomView.isHidden = viewModel.isCellBottomHidden[indexPath.row]
            cell.cellBottomViewModel.changeHiddenState(viewModel.isCellBottomHidden[indexPath.row])
            cell.selectionStyle = .none
            return cell
        case .pairs:
            let cell = PairsViewCell.dequeue(in: tableView, for: indexPath)
            cell.bottomView.isHidden = viewModel.isCellBottomHidden[indexPath.row]
            cell.cellBottomViewModel.changeHiddenState(viewModel.isCellBottomHidden[indexPath.row])
            cell.selectionStyle = .none
            return cell
        case .gameTimes:
            let cell = TimesViewCell.dequeue(in: tableView, for: indexPath)
            cell.bottomView.isHidden = viewModel.isCellBottomHidden[indexPath.row]
            cell.cellBottomViewModel.changeHiddenState(viewModel.isCellBottomHidden[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension StatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.toggleCellBottom(at: indexPath.row)
    }
}

extension StatsViewController: StatsViewModelDelegate {
    func statsViewModel(_ viewModel: StatsViewModel, didChangeStateAtIndex index: Int, withState state: Bool) {
        let indexPath = IndexPath(row: index, section: 0)
        if state {
            tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.top)
        } else {
            tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.bottom)
        }
    }
}
