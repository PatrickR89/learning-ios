//
//  ViewController.swift
//  challenge2-hangman
//
//  Created by Patrick on 13.06.2022..
//

import UIKit

class ViewController: UIViewController {

    var correctAnswer = "button".uppercased()
    var promptWord = ""

    var tries = 7 {
        didSet {
            triesLabel.text = "Tries: \(tries)"
        }
    }

    var score = 0 {
        didSet {
            if score < 0 {
                score = 0
            }
            scoreLabel.text = "Score: \(score)"
        }
    }

    var currentCharacter = "" {
        didSet {
            charEnter(char: currentCharacter)
        }
    }

    var usedLetters = [String]()
    var wrongAnswers = [String]()
    var allWords = [String]()

    lazy var triesLabel: UILabel = {
        let triesLabel = UILabel()
        triesLabel.translatesAutoresizingMaskIntoConstraints = false
        triesLabel.textAlignment = .left
        return triesLabel
    }()

    lazy var scoreLabel: UILabel = {
        let scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        return scoreLabel
    }()

    lazy var answer: UILabel = {
        let answer = UILabel()
        answer.translatesAutoresizingMaskIntoConstraints = false
        answer.textAlignment = .center
        return answer
    }()

    lazy var wrongAnswersLabel: UILabel = {
        let wrongAnswerLabel = UILabel()
        wrongAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
        wrongAnswerLabel.numberOfLines = 1
        return wrongAnswerLabel
    }()

    lazy var characterInput: UITextField = {
        let characterInput = UITextField()
        characterInput.translatesAutoresizingMaskIntoConstraints = false
        characterInput.textAlignment = .center
        characterInput.font = UIFont.systemFont(ofSize: 44)
        characterInput.layer.borderWidth = 1
        characterInput.layer.borderColor = UIColor.lightGray.cgColor
        characterInput.delegate = self

        return characterInput
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupScoreLabel()
        setupTriesLabel()
        setupAnswerLabel()
        setupCharacterInput()
        setupWrongAnswerLayout()

        DispatchQueue.global(qos: .userInitiated).async {
            self.loadSource()
            DispatchQueue.main.async {
                self.startGame()
            }
        }
    }
}
