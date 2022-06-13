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
        submitAnswer()
        answer?.text = promptWord
    }

    func handleWrongAnswer(char: String) {
        wrongAnswers.append(char.uppercased())
        let answersString = wrongAnswers.joined(separator: ", ")
        wrongAnswersLabel?.text = "Wrong tries: \(answersString)"
    }

    func submitAnswer() {
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
            winGame()
        }

        if tries == 0 {
            looseGame()
        }
    }

    func loadSource() {
        if let startURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }

        if allWords.isEmpty {
            allWords = ["Error loading"]
        }
    }

    func startGame() {
        correctAnswer = ""
        guard let word = allWords.randomElement() else {return}
        correctAnswer = word.uppercased()
        usedLetters.removeAll()
        wrongAnswers.removeAll()
        answer?.text = "_______"
        wrongAnswersLabel?.text = "Wrong tries:"
    }

    func looseGame() {
        let alertController = UIAlertController(title: "You lost", message: "You have 7 wrong attempts", preferredStyle: .alert)
        let continueGame = UIAlertAction(title: "Continue", style: .default, handler: handleLoose)
        alertController.addAction(continueGame)
        present(alertController, animated: true)
    }

    func winGame() {
        let alertController = UIAlertController(title: "Congratulations", message: "You win!", preferredStyle: .alert)
        let continueGame = UIAlertAction(title: "Continue", style: .default, handler: handleWin)
        alertController.addAction(continueGame)
        present(alertController, animated: true)
    }

    func handleWin(action: UIAlertAction) {
        score += 1
        tries = 7
        startGame()
    }

    func handleLoose(action: UIAlertAction) {
        tries = 7
        startGame()
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
