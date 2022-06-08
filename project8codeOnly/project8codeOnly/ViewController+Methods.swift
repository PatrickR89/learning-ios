//
//  ViewController+Methods.swift
//  project8codeOnly
//
//  Created by Patrick on 08.06.2022..
//

import UIKit

// MARK: Methods

extension ViewController {

    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else {return}
        guard let currentAnswer = currentAnswer else {return}
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
    }

    @objc func submitTapped(_ sender: UIButton) {
        guard let currentAnswer = currentAnswer,
              let answersLabel = answersLabel,
              let answerText = currentAnswer.text else {return}
        if let solutionPosition = solutions.firstIndex(of: answerText) {
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] = answerText
            answersLabel.text = splitAnswers?.joined(separator: "\n")

            activatedButtons.removeAll()
            currentAnswer.text = ""
            score += 1

            if letterButtons.allSatisfy({$0.isHidden == true}) {
                let alertController = UIAlertController(
                    title: "Well done",
                    message: "Ready for next level?",
                    preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ready!", style: .default, handler: levelUp))
                present(alertController, animated: true)
            }
        } else {
            let alertController = UIAlertController(
                title: "Wrong answer!",
                message: nil,
                preferredStyle: .alert)
            let continueGame = UIAlertAction(title: "Try again", style: .default) { [weak self] _ in
                if let clear = self?.clearBtn {
                    self?.clearTapped(clear)
                }
            }

            alertController.addAction(continueGame)
            score -= 1
            present(alertController, animated: true)
        }
    }

    @objc func clearTapped(_ sender: UIButton) {
        currentAnswer?.text = ""
        for button in activatedButtons {
            button.isHidden = false
        }
        activatedButtons.removeAll()
    }

    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()

        guard let levelFileURL = Bundle.main.url(
            forResource: "level\(level)",
            withExtension: ".txt") else {fatalError("No source found")}

        if let levelContents = try? String(contentsOf: levelFileURL) {
            var lines = levelContents.components(separatedBy: "\n")
            lines.shuffle()

            for (index, line) in lines.enumerated() {
                let parts = line.components(separatedBy: ": ")
                let answers = parts[0]
                let clue = parts[1]

                clueString += "\(index + 1). \(clue)\n"
                let solutionWord = answers.replacingOccurrences(of: "|", with: "")
                solutionString += "\(solutionWord.count) letters\n"
                solutions.append(solutionWord)

                let bits = answers.components(separatedBy: "|")
                letterBits += bits
            }
        }

        cluesLabel?.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel?.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)

        letterButtons.shuffle()
        if letterButtons.count == letterBits.count {
            for index in 0..<letterButtons.count {
                letterButtons[index].setTitle(letterBits[index], for: .normal)
            }
        }
    }

    func levelUp(action: UIAlertAction) {
        level += 1
        solutions.removeAll(keepingCapacity: true)
        loadLevel()
        for button in letterButtons {
            button.isHidden = false
        }
    }
}
