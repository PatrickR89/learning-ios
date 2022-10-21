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

    func setupUI(withExpandableView stackView: UIStackView, withBottomHiddenState isHidden: Bool) {
        stackView.removeFromSuperview()
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        if isHidden {
            stackView.distribution = .fillEqually
            stackView.spacing = 0
        } else {
            stackView.distribution = .equalSpacing
            stackView.spacing = 30
        }

        stackView.axis = .vertical
        stackView.alignment = .top

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
}
