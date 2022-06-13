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

    }
}

extension ViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
        let currentText = characterInput?.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {return false}
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 1
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {return}
        if text != "" {
            currentCharacter = text.uppercased()
        }
        textField.text = ""
    }
}

extension ViewController {
    func charEnter(char: String) {
        usedLetters.append(char.uppercased())
        setCorrectAnswer()
        answer?.text = promptWord
    }

    func handleWrongAnswer(char: String) {
        wrongAnswers.append(char.uppercased())
        let answersString = wrongAnswers.joined(separator: ", ")
        wrongAnswersLabel?.text = "Wrong tries: \(answersString)"
    }

    func setCorrectAnswer() {
        var tempWord = ""
        for char in correctAnswer {
            let charString = String(char)
            if usedLetters.contains(charString) {
                tempWord += charString
            } else {
                tempWord += "_"
            }
        }
        if !correctAnswer.contains(currentCharacter) && !wrongAnswers.contains(currentCharacter) {
            handleWrongAnswer(char: currentCharacter)
            tries -= 1
        }
        promptWord = tempWord

        if !promptWord.contains("_") {
            score += 1
        }
    }
}

// MARK: Structure and planning

// place number of tries out of 7
// place score *done*
// answer with characters hidden Answer: _______
// correct chosen letter reveals in answer
// wrong answer removes 1 from tries
// 0 tries - game end
// array of used wrong characters
// all characters revealed -> new word, add score 1

// MARK: UI plan

// Upper left corner - Tries: 7 *done*
// Upper right corner - Score: 0 *done*
// Centered - anwer - _______   *done*
// Under answer - input for characters  *done*
// Under input - wrong characters array *done*
// Free place for keyboard *done*
