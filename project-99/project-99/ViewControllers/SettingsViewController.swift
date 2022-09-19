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
        setupBindings()
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
        title = "\(viewModel.returnId())"
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.frame
        ThemeTableViewCell.register(in: tableView)
        MulticolorViewCell.register(in: tableView)
    }

    private func setupBindings() {
        viewModel.observeMulticolorState { _ in
            DispatchQueue.main.async { [weak self] in
                if let index = self?.tableContent.firstIndex(where: {$0.self == SettingsContent.multicolor}) {
                    let indexPath = IndexPath(row: index, section: 0)
                    self?.tableView.reloadRows(at: [indexPath], with: .fade)
                }
            }
        }
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
            if let theme = viewModel.returnTheme() {
                cell.changeValue(with: theme)
            }
            return cell
        case .multicolor:
            let cell = MulticolorViewCell.dequeue(in: tableView, for: indexPath)
            if let withMulticolor = viewModel.returnMulticolorState() {
                cell.changeMulticolorState(withMulticolor)
            }
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

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = tableContent[indexPath.row]

        switch content {

        case .theme:
            viewModel.changeTheme()
        case .multicolor:
            viewModel.changeMulticolor()
        case .timer:
            break
        case .username:
            break
        case .password:
            break
        }
    }
}
