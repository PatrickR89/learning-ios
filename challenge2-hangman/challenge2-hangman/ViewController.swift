//
//  ViewController.swift
//  challenge2-hangman
//
//  Created by Patrick on 13.06.2022..
//

import UIKit

class ViewController: UIViewController {

    var correctAnswer = "button".uppercased()
    var usedLetters = [String]()
    var promptWord = ""
    var tries = 7 {
        didSet {
            triesLabel?.text = "Tries: \(tries)"
        }
    }
    var triesLabel: UILabel?
    var score = 0 {
        didSet {
            if score < 0 {
                score = 0
            }
            scoreLabel?.text = "Score: \(score)"
        }
    }
    var scoreLabel: UILabel?
    var answer: UILabel?
    var characterInput: UITextField?
    var wrongAnswers = [String]()
    var wrongAnswersLabel: UILabel?
    var currentCharacter = "" {
        didSet {
            charEnter(char: currentCharacter)
        }
    }
    var allWords = [String]()

    override func loadView() {
        view = UIView()
        setScoreLabel()
        setTriesLabel()
        setAnswerLabel()
        setCharacterInput()
        setWrongAnswerLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        loadSource()
        startGame()
    }
}
