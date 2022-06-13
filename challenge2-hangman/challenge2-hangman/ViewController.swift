//
//  ViewController.swift
//  challenge2-hangman
//
//  Created by Patrick on 13.06.2022..
//

import UIKit

class ViewController: UIViewController {

    var tries = 7
    var triesLabel: UILabel?
    var score = 0
    var scoreLabel: UILabel?
    var answer: UILabel?
    var letterInput: UITextField?
    var wrongAnswers = [String]()

    override func loadView() {
        view = UIView()
        setScoreLabel()
        setTriesLabel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

// MARK: Structure and planning

// place number of tries out of 7
// place score
// answer with characters hidden Answer: _______
// correct chosen letter reveals in answer
// wrong answer removes 1 from tries
// 0 tries - game end
// array of used wrong characters
// all characters revealed -> new word, add score 1

// MARK: UI plan

// Upper left corner - Tries: 7
// Upper right corner - Score: 0
// Centered - anwer - _______
// Under answer - input for characters
// Under input - wrong characters array
// Free place for keyboard
