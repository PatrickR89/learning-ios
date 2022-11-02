//
//  SettingsTableViewDataSource.swift
//  project-99
//
//  Created by Patrick on 31.10.2022..
//

import UIKit

class SettingsTableViewDataSource:
    UITableViewDiffableDataSource<SettingsTableViewLayoutSections, SettingsTableViewLayoutItems> {
    init(_ tableView: UITableView, with viewModel: SettingsViewModel) {
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
