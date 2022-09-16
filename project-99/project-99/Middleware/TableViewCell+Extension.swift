//
//  TableViewCell+Extension.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import UIKit

extension UITableViewCell {
    static var defaultReuseIdentifier: String {String(describing: self)}

    static func register(in tableView: UITableView) {
        tableView.register(self, forCellReuseIdentifier: defaultReuseIdentifier)
    }

    static func dequeue(in tableView: UITableView, for indexPath: IndexPath) -> Self {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: defaultReuseIdentifier,
            for: indexPath) as? Self else {fatalError("Cell loading error")}
        return cell
    }
}
