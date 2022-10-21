//
//  TimesSubviewViewCell.swift
//  project-99
//
//  Created by Patrick on 22.09.2022..
//

import UIKit

class TimesSubviewViewCell: UITableViewCell {

    let labels = LabelLayoutView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()

        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(labels)
        labels.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labels.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labels.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labels.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9)
        ])
    }

    func addLabel(with title: String, and value: String) {
        labels.addTitleLabelText(title)
        labels.addValueLabelText(value)
    }
}
