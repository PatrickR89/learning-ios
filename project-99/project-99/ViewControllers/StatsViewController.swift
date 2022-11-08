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

    lazy var tableViewDataSource: UITableViewDiffableDataSource<
        StatsTableViewLayoutSections, StatsTableViewLayoutItems
    > = {
        let dataSource = UITableViewDiffableDataSource<
            StatsTableViewLayoutSections, StatsTableViewLayoutItems
        >(tableView: tableView) { [weak self] tableView, indexPath, itemIdentifier in
            let cell = StatCell.dequeue(in: tableView, for: indexPath)

            func updateCell(with model: StatCellModel) {
                cell.updateCellData(model)
                cell.changeBottomState(with: self?.viewModel.isCellBottomHidden[indexPath.row] ?? true)
                cell.selectionStyle = .none
            }

            switch itemIdentifier {
            case .games(let model):
                updateCell(with: model)
            case .pairs(let model):
                updateCell(with: model)
            case .gameTimes(let model):
                updateCell(with: model)
            }

            return cell
        }

        return dataSource
    }()

    init(with viewModel: StatsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
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
        viewModel.hideAllCellBottoms()
        self.dismiss(animated: true)
    }

    private func setupUI() {
        view.appendViews([tableView])
        StatCell.register(in: tableView)
        tableView.delegate = self
        reloadTableView(isInitial: true)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, constant: -50),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

    func reloadTableView(isInitial: Bool) {
        var content = [StatsTableViewLayoutItems]()

        for (index, value) in StatsContent.allCases.enumerated() {
            if value == .games {
                content.append(StatsTableViewLayoutItems.games(
                    StatCellModel(content: value, isExtended: viewModel.isCellBottomHidden[index])))
            }

            if value == .pairs {
                content.append(StatsTableViewLayoutItems.pairs(
                    StatCellModel(content: value, isExtended: viewModel.isCellBottomHidden[index])))
            }

            if value == .gameTimes {
                content.append(StatsTableViewLayoutItems.gameTimes(
                    StatCellModel(content: value, isExtended: viewModel.isCellBottomHidden[index])))
            }
        }

        var snapshot = NSDiffableDataSourceSnapshot<StatsTableViewLayoutSections, StatsTableViewLayoutItems>()
        snapshot.appendSections([.main])
        snapshot.appendItems(content, toSection: .main)

        tableViewDataSource.defaultRowAnimation = .top
        if isInitial {
            tableViewDataSource.applySnapshotUsingReloadData(snapshot)
        } else {
            tableViewDataSource.apply(snapshot)
        }
    }
}

extension StatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.toggleCellBottom(at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = tableViewDataSource.itemIdentifier(for: indexPath)
        if viewModel.isCellBottomHidden[indexPath.row] {
            return 40
        } else {
            switch item {
            case .gameTimes:
                return 350
            default:
                return 180
            }
        }
    }
}

extension StatsViewController: StatsViewModelDelegate {
    func statsViewModel(_ viewModel: StatsViewModel, didChangeStateAtIndex index: Int, withState state: Bool) {
        reloadTableView(isInitial: false)
    }
}
