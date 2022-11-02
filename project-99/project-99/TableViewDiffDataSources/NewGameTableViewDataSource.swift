//
//  NewGameTableViewDataSource.swift
//  project-99
//
//  Created by Patrick on 31.10.2022..
//

import UIKit

class NewGameTableViewDataSource: UITableViewDiffableDataSource<NewGameTableViewSections, NewGameTableViewItems> {
    init(_ tableView: UITableView, with viewModel: SettingsViewModel) {
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = NewGameCell.dequeue(in: tableView, for: indexPath)

            switch itemIdentifier {
            case .game(let model):
                cell.updateCellData(with: model)
            }
            return cell
        }
    }
}
