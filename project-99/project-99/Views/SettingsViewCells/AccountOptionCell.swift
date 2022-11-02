//
//  AccountOptionCell.swift
//  project-99
//
//  Created by Patrick on 19.09.2022..
//

import UIKit

class AccountOptionCell: UITableViewCell {

    private let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI(withSingleLabel: titleLabel)

        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateCellData(with model: AccountOptionCellModel) {
        titleLabel.text = model.title
        if model.destructive {
            titleLabel.textColor = .red
        } else {
            titleLabel.textColor = .systemBlue
        }
    }
}
