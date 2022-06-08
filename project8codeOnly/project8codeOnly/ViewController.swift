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

// MARK: Setup View layout

extension ViewController {
    func setScoreLabel() {
        scoreLabel = UILabel()

        if let scoreLabel = scoreLabel {
            scoreLabel.translatesAutoresizingMaskIntoConstraints = false
            scoreLabel.textAlignment = .right
            scoreLabel.text = "Score: 0"
            view.addSubview(scoreLabel)

            NSLayoutConstraint.activate([
                scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)

            ])

        }
    }

    func setCluesLabel() {
        cluesLabel = UILabel()

        if let cluesLabel = cluesLabel, let scoreLabel = scoreLabel {
            cluesLabel.translatesAutoresizingMaskIntoConstraints = false
            cluesLabel.font = UIFont.systemFont(ofSize: 24)
            cluesLabel.text = "CLUES"
            cluesLabel.numberOfLines = 0
            cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
            view.addSubview(cluesLabel)

            NSLayoutConstraint.activate([
                cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
                cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
                cluesLabel.widthAnchor.constraint(
                    equalTo: view.layoutMarginsGuide.widthAnchor,
                    multiplier: 0.6,
                    constant: -100)
            ])
        }
    }

    func setAnswersLabel() {
        answersLabel = UILabel()

        if let answersLabel = answersLabel, let scoreLabel = scoreLabel, let cluesLabel = cluesLabel {
            answersLabel.translatesAutoresizingMaskIntoConstraints = false
            answersLabel.font = UIFont.systemFont(ofSize: 24)
            answersLabel.text = "ANSWERS"
            answersLabel.textAlignment = .right
            answersLabel.numberOfLines = 0
            answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
            view.addSubview(answersLabel)

            NSLayoutConstraint.activate([
                answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
                answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
                answersLabel.widthAnchor.constraint(
                    equalTo: view.layoutMarginsGuide.widthAnchor,
                    multiplier: 0.4,
                    constant: -100),
                answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor)
            ])
        }
    }

    func setCurrentAnswerLayout() {
        currentAnswer = UITextField()

        if let currentAnswer = currentAnswer, let cluesLabel = cluesLabel {
            currentAnswer.translatesAutoresizingMaskIntoConstraints = false
            currentAnswer.placeholder = "Tap letters to guess"
            currentAnswer.textAlignment = .center
            currentAnswer.font = UIFont.systemFont(ofSize: 44)
            currentAnswer.isUserInteractionEnabled = false
            view.addSubview(currentAnswer)

            NSLayoutConstraint.activate([
                currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
                currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20)
            ])
        }

    }

    func setButtons() {
        submitBtn.translatesAutoresizingMaskIntoConstraints = false
        submitBtn.setTitle("SUBMIT", for: .normal)
        submitBtn.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submitBtn)

        clearBtn.translatesAutoresizingMaskIntoConstraints = false
        clearBtn.setTitle("CLEAR", for: .normal)
        clearBtn.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clearBtn)

        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)

        if let currentAnswer = currentAnswer {
            NSLayoutConstraint.activate([
                submitBtn.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
                submitBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
                submitBtn.heightAnchor.constraint(equalToConstant: 44),
                clearBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
                clearBtn.heightAnchor.constraint(equalToConstant: 44),
                clearBtn.centerYAnchor.constraint(equalTo: submitBtn.centerYAnchor),
                buttonsView.widthAnchor.constraint(equalToConstant: 750),
                buttonsView.heightAnchor.constraint(equalToConstant: 320),
                buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                buttonsView.topAnchor.constraint(equalTo: submitBtn.bottomAnchor, constant: 20),
                buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
            ])
        }

        let width = 150
        let height = 80

        for row in 0..<4 {
            for col in 0..<5 {
                let letterBtn = UIButton(type: .system)
                letterBtn.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterBtn.setTitle("WWW", for: .normal)
                letterBtn.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)

                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterBtn.frame = frame
                buttonsView.addSubview(letterBtn)
                letterButtons.append(letterBtn)
            }
        }
    }
}

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

            if score % 7 == 0 {
                let alertController = UIAlertController(title: "Well done", message: "Ready for next level?", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ready!", style: .default, handler: levelUp))
                present(alertController, animated: true)
            }
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

        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: ".txt") {
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
        for button in letterButtons{
            button.isHidden = false
        }
    }
}
