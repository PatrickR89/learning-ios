//
//  GridLayoutView.swift
//  project-99
//
//  Created by Patrick on 24.10.2022..
//

import UIKit

class GridLayoutView: UIView {

    var columns = [CardsColumn]()

    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(with columns: [[GameCard]], in level: Level) {
        for (index, column) in columns.enumerated() {
            let newColumn = CardsColumn(cards: column, in: level)
            self.columns.append(newColumn)
            self.addSubview(self.columns[index])
            self.columns[index].translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.columns[index].topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
                self.columns[index].bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
            ])

            if index == 0 {
                self.columns[index].leadingAnchor.constraint(
                    equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
            }

            if index > 0 {
                NSLayoutConstraint.activate([
                    self.columns[index].leadingAnchor.constraint(equalTo: self.columns[index - 1].trailingAnchor),
                    self.columns[index].widthAnchor.constraint(equalTo: self.columns[index - 1].widthAnchor)
                ])
            }

            if index == columns.count - 1 {
                NSLayoutConstraint.activate([
                    self.columns[index].trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
                ])
            }
        }
    }
}
