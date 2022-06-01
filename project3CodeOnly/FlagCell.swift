//
//  FlagCell.swift
//  project3CodeOnly
//
//  Created by Patrick on 31.05.2022..
//

import UIKit

class FlagCell: UITableViewCell {

    var label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(label)

        configureLabel()
        setLabelConstraints()

        func configureLabel() {
            label.numberOfLines = 0
            label.adjustsFontSizeToFitWidth = true
        }

        func setLabelConstraints() {
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.centerYAnchor.constraint(equalTo: centerYAnchor),
                label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
            ])
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
