//
//  ViewController+Methods.swift
//  challenge2-hangman
//
//  Created by Patrick on 13.06.2022..
//

import UIKit

extension ViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
            guard let currentText = characterInput?.text else {return false}
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
        if let startURL = Bundle.main.url(forResource: "hangmanWords", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }

        if allWords.isEmpty {
            let alertController = UIAlertController(title: "Error", message: "Error occured. Source file was not found", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))

            present(alertController, animated: true)
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
        let alertController = UIAlertController(
            title: "You lost",
            message: "You have 7 wrong attempts",
            preferredStyle: .alert)
        let continueGame = UIAlertAction(
            title: "Continue",
            style: .default,
            handler: handleLoose)
        alertController.addAction(continueGame)
        present(alertController, animated: true)
    }

    func winGame() {
        let alertController = UIAlertController(
            title: "Congratulations",
            message: "You win!",
            preferredStyle: .alert)
        let continueGame = UIAlertAction(
            title: "Continue",
            style: .default,
            handler: handleWin)
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
