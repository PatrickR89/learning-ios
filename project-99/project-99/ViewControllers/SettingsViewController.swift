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
    var tableViewDataSource: SettingsTableViewDataSource
    private var cancellables = [AnyCancellable]()

    weak var delegate: SettingsViewControllerDelegate?

    init(with viewModel: SettingsViewModel) {
        self.tableView = UITableView()
        self.viewModel = viewModel
        self.tableViewDataSource = SettingsTableViewDataSource(tableView)
        super.init(nibName: nil, bundle: nil)
        setupUI()

        use(AppTheme.self) {
            $0.tableView.backgroundColor = $1.backgroundColor
            $0.navigationItem.leftBarButtonItem?.tintColor = $1.textColor
            $0.reloadInputViews()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDataSource.reloadData(true, with: viewModel)

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark.circle"),
            style: .plain,
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
        view.appendViews([tableView])
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.frame = view.frame
        ThemeCell.register(in: tableView)
        GameOptionCell.register(in: tableView)
        AccountOptionCell.register(in: tableView)
        setupBindings()
    }

    private func setupBindings() {
        viewModel.delegate = self

        viewModel.$withMulticolor
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let self =  self else {return}
                self.tableViewDataSource.reloadData(false, with: self.viewModel)
            })
            .store(in: &cancellables)

        viewModel.$withTimer
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] _ in
                guard let self =  self else {return}
                self.tableViewDataSource.reloadData(false, with: self.viewModel)
            })
            .store(in: &cancellables)

        viewModel.$userTheme
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let self =  self else {return}
                self.tableViewDataSource.reloadData(false, with: self.viewModel)
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

extension SettingsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = tableViewDataSource.itemIdentifier(for: indexPath)

        switch content {
        case .theme:
            viewModel.changeTheme()
        case .gameOption(let model):
            switch model.cellType {
            case .multicolor:
                viewModel.toggleMulticolor()
            case .timer:
                viewModel.toggleTimer()
            }
        case .accountOption(let model):
            let alertController = viewModel.addPasswordVerificationAlertController(for: model.type)
            present(alertController, animated: true)
        case .none:
            return
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
        for change: AccountOption) {

            if !result {
                let alertController = viewModel.addInvalidPasswordAlertController()
                present(alertController, animated: true)
            } else {
                let alertController = viewModel.addChangeAccountAlertController(in: self, for: change)
                present(alertController, animated: true)
            }
        }
}
