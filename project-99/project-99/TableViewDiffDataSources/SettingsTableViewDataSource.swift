//
//  SettingsTableViewDataSource.swift
//  project-99
//
//  Created by Patrick on 31.10.2022..
//

import UIKit

class SettingsTableViewDataSource:
    UITableViewDiffableDataSource<SettingsTableViewLayoutSections, SettingsTableViewLayoutItems> {

    init(_ tableView: UITableView) {
        super.init(tableView: tableView) {tableView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .theme(let model):
                let cell = ThemeCell.dequeue(in: tableView, for: indexPath)
                cell.updateCellData(with: model)
                return cell
            case .gameOption(let model):
                let cell = GameOptionCell.dequeue(in: tableView, for: indexPath)
                cell.updateCellData(with: model)
                return cell
            case .accountOption(let model):
                let cell = AccountOptionCell.dequeue(in: tableView, for: indexPath)
                cell.updateCellData(with: model)
                return cell
            }
        }
    }

    func reloadData(_ isInitial: Bool, with viewModel: SettingsViewModel) {
        let theme = SettingsTableViewLayoutItems.theme(ThemeTableCellModel(with: viewModel))
        let multicolor = SettingsTableViewLayoutItems.gameOption(GameOptionCellModel(with: .multicolor, and: viewModel))
        let timer = SettingsTableViewLayoutItems.gameOption(GameOptionCellModel(with: .timer, and: viewModel))
        let username = SettingsTableViewLayoutItems.accountOption(AccountOptionCellModel(AccountOption.username))
        let password = SettingsTableViewLayoutItems.accountOption(AccountOptionCellModel(AccountOption.password))
        let delete = SettingsTableViewLayoutItems.accountOption(AccountOptionCellModel(AccountOption.delete))

        let gameOptions: [SettingsTableViewLayoutItems] = [theme, multicolor, timer]
        let userOptions: [SettingsTableViewLayoutItems] = [username, password, delete]

        var snapshot = NSDiffableDataSourceSnapshot<SettingsTableViewLayoutSections, SettingsTableViewLayoutItems>()
        snapshot.appendSections([.gameSettings, .accountSettings])
        snapshot.appendItems(gameOptions, toSection: .gameSettings)
        snapshot.appendItems(userOptions, toSection: .accountSettings)

        if isInitial {
            self.apply(snapshot)
        } else {
            self.defaultRowAnimation = .fade
            self.apply(snapshot, animatingDifferences: true)
        }

    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let id = sectionIdentifier(for: section)

        switch id {
        case .gameSettings:
            return "Game settings"
        case .accountSettings:
            return "Account settings"
        default:
            return ""
        }
    }
}
