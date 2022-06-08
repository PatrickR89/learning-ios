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

        }
    }

    func setCluesLabel() {
        cluesLabel = UILabel()

        if let cluesLabel = cluesLabel {
            cluesLabel.translatesAutoresizingMaskIntoConstraints = false
            cluesLabel.font = UIFont.systemFont(ofSize: 24)
            cluesLabel.text = "CLUES"
            cluesLabel.numberOfLines = 0
            view.addSubview(cluesLabel)
        }
    }

    func setAnswersLabel() {
        answersLabel = UILabel()

        if let answersLabel = answersLabel {
            answersLabel.translatesAutoresizingMaskIntoConstraints = false
            answersLabel.font = UIFont.systemFont(ofSize: 24)
            answersLabel.text = "ANSWERS"
            answersLabel.numberOfLines = 0
            view.addSubview(answersLabel)
        }
    }
}
