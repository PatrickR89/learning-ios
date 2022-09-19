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
    private let primaryContent: [SettingsContent] = [.theme, .multicolor, .timer]
    private let secondContent: [SettingsContent] = [.username, .password]
    private let sections: [[SettingsContent]]

    weak var delegate: SettingsViewControllerDelegate?

    init(with viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        self.sections = [primaryContent, secondContent]
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
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.frame
        ThemeTableViewCell.register(in: tableView)
        MulticolorViewCell.register(in: tableView)
        TimerViewCell.register(in: tableView)
        UsernameViewCell.register(in: tableView)
        PasswordViewCell.register(in: tableView)
    }

    private func setupBindings() {
        viewModel.delegate = self
        viewModel.observeMulticolorState { _ in
            DispatchQueue.main.async { [weak self] in
                if let index = self?.primaryContent.firstIndex(where: {$0.self == SettingsContent.multicolor}) {
                    let indexPath = IndexPath(row: index, section: 0)
                    self?.tableView.reloadRows(at: [indexPath], with: .fade)
                }
            }
        }

        viewModel.observerTimerState { _ in
            DispatchQueue.main.async { [weak self] in
                if let index = self?.primaryContent.firstIndex(where: {$0.self == SettingsContent.timer}) {
                    let indexPath = IndexPath(row: index, section: 0)
                    self?.tableView.reloadRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
}

extension SettingsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = sections[indexPath.section][indexPath.row]

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
            let cell = TimerViewCell.dequeue(in: tableView, for: indexPath)
            if let withTimer = viewModel.returnTimerState() {
                cell.changeTimerState(withTimer)
            }
            return cell
        case .username:
            let cell = UsernameViewCell.dequeue(in: tableView, for: indexPath)
            return cell
        case .password:
            let cell = PasswordViewCell.dequeue(in: tableView, for: indexPath)
            return cell
        }
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = sections[indexPath.section][indexPath.row]

        switch content {

        case .theme:
            viewModel.changeTheme()
        case .multicolor:
            viewModel.changeMulticolor()
        case .timer:
            viewModel.changeTimer()
        case .username:
            let alertController = viewModel.addPasswordVerificationAlertController(in: self, for: .username)
            present(alertController, animated: true)
        case .password:
            let alertController = viewModel.addPasswordVerificationAlertController(in: self, for: .password)
            present(alertController, animated: true)
        }
    }
}

extension SettingsViewController: SettingsViewModelDelegate {
    func settingsViewModel(_ viewModel: SettingsViewModel, didChangeUsername username: String) {
        delegate?.settingsViewController(self, didRecieveUpdatedName: username)
    }

    func settingsViewModel(
        _ viewModel: SettingsViewModel,
        didVerifyPasswordWithResult result: Bool,
        for change: AccountChanges) {

        if !result {
            let alertController = viewModel.addInvalidPasswordAlertController(in: self)
            present(alertController, animated: true)
        } else {
            let alertController = viewModel.addChangeAccountAlertController(in: self, for: change)
            present(alertController, animated: true)
        }
    }
}
