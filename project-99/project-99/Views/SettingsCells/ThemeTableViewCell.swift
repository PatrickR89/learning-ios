//
//  ThemeTableViewCell.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import UIKit

class ThemeTableViewCell: UITableViewCell {

    private let title = UILabel()
    private let value = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .green
        title.text = "Theme cell"

        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
