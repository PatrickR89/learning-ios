//
//  ViewController+UILayouts.swift
//  challenge2-hangman
//
//  Created by Patrick on 13.06.2022..
//

import UIKit

extension ViewController {
    func setScoreLabel() {
        let scoreLabel = UILabel()
        scoreLabel.text = "Score: 0"
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        view.addSubview(scoreLabel)

        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])

        self.scoreLabel = scoreLabel
    }

    func setTriesLabel() {
        let triesLabel = UILabel()
        triesLabel.text = "Tries: 7"
        triesLabel.translatesAutoresizingMaskIntoConstraints = false
        triesLabel.textAlignment = .left
        view.addSubview(triesLabel)

        NSLayoutConstraint.activate([
            triesLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            triesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        ])

        self.triesLabel = triesLabel
    }
}
