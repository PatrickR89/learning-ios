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

    let buttonsView = UIView()

    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()

    let submitBtn = UIButton(type: .system)
    let clearBtn = UIButton(type: .system)

    var solutions = [String]()

    var score = 0 {
        didSet {
            if score < 0 {
                score = 0
            }
            scoreLabel?.text = "Score: \(score)"
        }
    }
    var level = 1

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        setScoreLabel()
        setCluesLabel()
        setAnswersLabel()
        setCurrentAnswerLayout()
        setButtons()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadLevel()
    }
}
