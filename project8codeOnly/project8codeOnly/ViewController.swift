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
}
