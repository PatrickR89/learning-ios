//
//  DeleteAccViewCell.swift
//  project-99
//
//  Created by Patrick on 14.10.2022..
//

import UIKit

class DeleteAccViewCell: UITableViewCell {

    private let titleLabel = UILabel()

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
        self.setupUI(withSingleLabel: titleLabel)
        titleLabel.text = "Delete account"
        titleLabel.textColor = .red
    }
}
