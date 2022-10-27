//
//  SettingsViewController.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import UIKit
import Combine

class SettingsViewController: UIViewController {

    private let viewModel: SettingsViewModel
    private let tableView: UITableView
    private let primaryContent: [SettingsContent] = [.theme, .multicolor, .timer]
    private let secondContent: [SettingsContent] = [.username, .password, .delete]
    private let sections: [[SettingsContent]]
    private var cancellables = [AnyCancellable]()

    weak var delegate: SettingsViewControllerDelegate?

    init(with viewModel: SettingsViewModel) {
        self.tableView = UITableView()
        self.viewModel = viewModel
        self.sections = [primaryContent, secondContent]
        super.init(nibName: nil, bundle: nil)
        setupUI()
        use(AppTheme.self) {
            $0.tableView.backgroundColor = $1.backgroundColor
            $0.reloadInputViews()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(dismissSelf))
    }

    @objc private func dismissSelf() {
        self.dismiss(animated: true)
    }

    deinit {
        viewModel.saveSettings()
        cancellables.forEach {
            $0.cancel()
        }
    }

    private func setupUI() {
        view.addViews([tableView])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.frame
        ThemeTableViewCell.register(in: tableView)
        MulticolorViewCell.register(in: tableView)
        TimerViewCell.register(in: tableView)
        UsernameViewCell.register(in: tableView)
        PasswordViewCell.register(in: tableView)
        DeleteAccViewCell.register(in: tableView)

        setupBindings()
    }

    private func setupBindings() {
        viewModel.delegate = self

        viewModel.$withMulticolor
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                if let index = self?.primaryContent.firstIndex(where: {$0.self == SettingsContent.multicolor}) {
                    let indexPath = IndexPath(row: index, section: 0)
                    self?.tableView.reloadRows(at: [indexPath], with: .fade)
                }
            })
            .store(in: &cancellables)

        viewModel.$withTimer
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] _ in
                if let index = self?.primaryContent.firstIndex(where: {$0.self == SettingsContent.timer}) {
                    let indexPath = IndexPath(row: index, section: 0)
                    self?.tableView.reloadRows(at: [indexPath], with: .fade)
                }
            })
            .store(in: &cancellables)

        viewModel.$userTheme
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &cancellables)

        viewModel.$newUsername
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] name in
                guard let self = self,
                      let name = name else {return}
                self.delegate?.settingsViewController(self, didRecieveUpdatedName: name)
            })
            .store(in: &cancellables)
    }
}

extension SettingsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Game settings"
        case 1:
            return "Account settings"
        default:
            return ""
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = sections[indexPath.section][indexPath.row]

        switch content {

        case .theme:
            let cell = ThemeTableViewCell.dequeue(in: tableView, for: indexPath)
            if let theme = viewModel.provideUserTheme() {
                cell.changeValue(with: theme)
            }
            return cell
        case .multicolor:
            let cell = MulticolorViewCell.dequeue(in: tableView, for: indexPath)
            if let withMulticolor = viewModel.provideUserMulticolorState() {
                cell.multicolorStateDidChange(withNewState: withMulticolor)
            }
            return cell
        case .timer:
            let cell = TimerViewCell.dequeue(in: tableView, for: indexPath)
            if let withTimer = viewModel.provideUserTimerState() {
                cell.timerStateDidChange(withNewState: withTimer)
            }
            return cell
        case .username:
            let cell = UsernameViewCell.dequeue(in: tableView, for: indexPath)
            return cell
        case .password:
            let cell = PasswordViewCell.dequeue(in: tableView, for: indexPath)
            return cell
        case .delete:
            let cell = DeleteAccViewCell.dequeue(in: tableView, for: indexPath)
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
            viewModel.toggleMulticolor()
        case .timer:
            viewModel.toggleTimer()
        case .username:
            let alertController = viewModel.addPasswordVerificationAlertController(in: self, for: .username)
            present(alertController, animated: true)
        case .password:
            let alertController = viewModel.addPasswordVerificationAlertController(in: self, for: .password)
            present(alertController, animated: true)
        case .delete:
            let alertController = viewModel.addPasswordVerificationAlertController(in: self, for: .delete)
            present(alertController, animated: true)
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SettingsViewController: SettingsViewModelDelegate {
    func settingsViewModelDidDeleteAccount(_ viewModel: SettingsViewModel) {
        delegate?.settingsViewController(self, didReciveAccountDeletionFrom: viewModel)
        self.dismiss(animated: true)
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
