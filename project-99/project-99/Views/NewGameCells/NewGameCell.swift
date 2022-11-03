//
//  NewGameCell.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import UIKit

class NewGameCell: UITableViewCell {

    private let levelLabel = UILabel()
    private let livesLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI(withLabels: levelLabel, and: livesLabel)

        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
            $0.levelLabel.textColor = $1.textColor
            $0.livesLabel.textColor = $1.textColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateCellData(with model: NewGameCellModel) {
        levelLabel.text = model.title
        livesLabel.text = model.chances
    }
}
