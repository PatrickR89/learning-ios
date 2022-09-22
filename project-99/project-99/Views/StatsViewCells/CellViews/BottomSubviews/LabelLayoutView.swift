//
//  LabelLayout.swift
//  project-99
//
//  Created by Patrick on 22.09.2022..
//

import UIKit

class LabelLayoutView: UIView {

    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    private let rowStack = UIStackView()

    init() {
        super.init(frame: .zero)
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
        self.addSubview(rowStack)
        rowStack.arrangeView(asRowWith: titleLabel, and: valueLabel)
        valueLabel.textColor = .systemBlue

        NSLayoutConstraint.activate([
            rowStack.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }

    func addTitle(_ title: String) {
        self.titleLabel.text = title
    }

    func addValue(_ value: String) {
        self.valueLabel.text = value
    }
}
