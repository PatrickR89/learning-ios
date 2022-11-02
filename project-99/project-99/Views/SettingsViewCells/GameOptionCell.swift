//
//  GameOptionCell.swift
//  project-99
//
//  Created by Patrick on 19.09.2022..
//

import UIKit

class GameOptionCell: UITableViewCell {

    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI(withLabels: titleLabel, and: valueLabel)

        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
            $0.titleLabel.textColor = $1.textColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateCellData(with model: GameOptionCellModel) {
        titleLabel.text = model.title
        switch model.cellType {
        case .multicolor:
            if model.value {
                valueLabel.text = "yes"
            } else {
                valueLabel.text = "no"
            }
        case .timer:
            if model.value {
                valueLabel.text = "on"
            } else {
                valueLabel.text = "off"
            }
        }
    }
}
