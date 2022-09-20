//
//  TimerViewCell.swift
//  project-99
//
//  Created by Patrick on 19.09.2022..
//

import UIKit

class TimerViewCell: UITableViewCell {

    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

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
        self.setupUI(withLabels: titleLabel, and: valueLabel)
        titleLabel.text = "Timer:"
        valueLabel.text = "off"
    }

    func changeTimerState(_ withTimer: Bool) {
        if withTimer {
            valueLabel.text = "on"
        } else {
            valueLabel.text = "off"
        }
    }
}
