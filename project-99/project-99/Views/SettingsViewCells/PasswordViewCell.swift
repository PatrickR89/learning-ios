//
//  PasswordViewCell.swift
//  project-99
//
//  Created by Patrick on 19.09.2022..
//

import UIKit

class PasswordViewCell: UITableViewCell {

    private let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()

        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
            $0.titleLabel.textColor = $1.textColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.setupSingleLable(with: titleLabel)
        titleLabel.text = "Change password"
    }
}
