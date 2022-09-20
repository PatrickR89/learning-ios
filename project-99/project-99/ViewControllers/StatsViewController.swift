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

    init(with viewModel: StatsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        use(AppTheme.self) {
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
        GamesViewCell.register(in: tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.frame
    }
}

extension StatsViewController: UITableViewDataSource {

//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = GamesViewCell.dequeue(in: tableView, for: indexPath)
        cell.bottomView.isHidden = viewModel.isCellBottomHidden[indexPath.row]
        return cell
    }
}
extension StatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = tableView.cellForRow(at: indexPath) as? GamesViewCell
//            else { return }
        viewModel.toggleCellBottom(at: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
