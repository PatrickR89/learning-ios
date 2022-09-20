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

    func setupUI(withSingleLabel label: UILabel) {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    func setupUI(withLabels titleLabel: UILabel, and valueLabel: UILabel) {
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.textColor = .systemBlue

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            valueLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor)
        ])
    }

    func setupUI(withExpandableView stack: UIStackView) {
        self.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .top
        stack.spacing = 30

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            stack.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: 20)
        ])
    }
}
