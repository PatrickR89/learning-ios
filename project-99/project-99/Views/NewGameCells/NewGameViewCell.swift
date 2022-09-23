//
//  NewGameViewCell.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import UIKit

class NewGameViewCell: UITableViewCell {

    private let levelLabel = UILabel()
    private let livesLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
            $0.levelLabel.textColor = $1.textColor
            $0.livesLabel.textColor = $1.textColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.setupUI(withLabels: levelLabel, and: livesLabel)
        levelLabel.text = "Easy"
        livesLabel.text = "Lives: Unlimited"
    }

    func setupLevelLabel(with level: Level) {
        switch level {
        case .veryEasy:
            levelLabel.text = "Very Easy"
            livesLabel.text = "Lives: Unlimited"
        case .easy:
            levelLabel.text = "Easy"
            livesLabel.text = "Lives: Unlimited"
        case .mediumHard:
            levelLabel.text = "Medium"
            livesLabel.text = "Lives: 30"
        case .hard:
            levelLabel.text = "Hard"
            livesLabel.text = "Lives: 30"
        case .veryHard:
            levelLabel.text = "Very hard"
            livesLabel.text = "Lives: 15"
        case .emotionalDamage:
            levelLabel.text = "Emotional damage"
            livesLabel.text = "Lives: 10"
        }
    }
}
