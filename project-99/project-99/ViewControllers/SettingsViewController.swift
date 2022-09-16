//
//  SettingsViewController.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import UIKit

class SettingsViewController: UIViewController {

    private let viewModel: SettingsViewModel
    private let tableView = UITableView()
    private let tableContent: [SettingsContent] = [.theme, .multicolor, .timer, .username, .password]

    init(with viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(viewModel.returnId())"
        view.backgroundColor = .white
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.frame = view.frame
        ThemeTableViewCell.register(in: tableView)
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableContent.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = tableContent[indexPath.row]

        switch content {

        case .theme:
            let cell = ThemeTableViewCell.dequeue(in: tableView, for: indexPath)
            return cell
        case .multicolor:
            let cell = ThemeTableViewCell.dequeue(in: tableView, for: indexPath)
            return cell
        case .timer:
            let cell = ThemeTableViewCell.dequeue(in: tableView, for: indexPath)
            return cell
        case .username:
            let cell = ThemeTableViewCell.dequeue(in: tableView, for: indexPath)
            return cell
        case .password:
            let cell = ThemeTableViewCell.dequeue(in: tableView, for: indexPath)
            return cell
        }
    }
}
