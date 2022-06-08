//
//  ViewController.swift
//  project8codeOnly
//
//  Created by Patrick on 08.06.2022..
//

import UIKit

class ViewController: UIViewController {

    var cluesLabel: UILabel?
    var answersLabel: UILabel?
    var currentAnswer: UITextField?
    var scoreLabel: UILabel?
    var letterButtons = [UIButton]()

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        setScoreLabel()
        setCluesLabel()
        setAnswersLabel()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController {
    func setScoreLabel() {
        scoreLabel = UILabel()

        if let scoreLabel = scoreLabel {
            scoreLabel.translatesAutoresizingMaskIntoConstraints = false
            scoreLabel.textAlignment = .right
            scoreLabel.text = "Score: 0"
            view.addSubview(scoreLabel)

            NSLayoutConstraint.activate([
                scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)

            ])

        }
    }

    func setCluesLabel() {
        cluesLabel = UILabel()

        if let cluesLabel = cluesLabel, let scoreLabel = scoreLabel {
            cluesLabel.translatesAutoresizingMaskIntoConstraints = false
            cluesLabel.font = UIFont.systemFont(ofSize: 24)
            cluesLabel.text = "CLUES"
            cluesLabel.numberOfLines = 0
            view.addSubview(cluesLabel)

            NSLayoutConstraint.activate([
                cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
                cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
                cluesLabel.widthAnchor.constraint(
                    equalTo: view.layoutMarginsGuide.widthAnchor,
                    multiplier: 0.6,
                    constant: -100)
            ])
        }
    }

    func setAnswersLabel() {
        answersLabel = UILabel()

        if let answersLabel = answersLabel, let scoreLabel = scoreLabel, let cluesLabel = cluesLabel {
            answersLabel.translatesAutoresizingMaskIntoConstraints = false
            answersLabel.font = UIFont.systemFont(ofSize: 24)
            answersLabel.text = "ANSWERS"
            answersLabel.numberOfLines = 0
            view.addSubview(answersLabel)

            NSLayoutConstraint.activate([
                answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
                answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
                answersLabel.widthAnchor.constraint(
                    equalTo: view.layoutMarginsGuide.widthAnchor,
                    multiplier: 0.4,
                    constant: -100),
                answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor)
            ])
        }
    }
}
