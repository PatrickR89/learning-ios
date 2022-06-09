//
//  ViewController+UILayout.swift
//  project8codeOnly
//
//  Created by Patrick on 08.06.2022..
//

import UIKit

// MARK: Setup View layout

extension ViewController {
    func setScoreLabel() {
        let scoreLabel = UILabel()
        scoreLabel.text = "Score: 0"
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right

        view.addSubview(scoreLabel)

        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        self.scoreLabel = scoreLabel
    }

    func setCluesLabel() {
        let cluesLabel = UILabel()

        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(cluesLabel)

        NSLayoutConstraint.activate([
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel!.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.widthAnchor.constraint(
                equalTo: view.layoutMarginsGuide.widthAnchor,
                multiplier: 0.6,
                constant: -100)
        ])
        self.cluesLabel = cluesLabel
    }

    func setAnswersLabel() {
        let answersLabel = UILabel()

        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.textAlignment = .right
        answersLabel.numberOfLines = 0
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answersLabel)

        NSLayoutConstraint.activate([
            answersLabel.topAnchor.constraint(equalTo: scoreLabel!.bottomAnchor),
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answersLabel.widthAnchor.constraint(
                equalTo: view.layoutMarginsGuide.widthAnchor,
                multiplier: 0.4,
                constant: -100),
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel!.heightAnchor)
        ])
        self.answersLabel = answersLabel

    }

    func setCurrentAnswerLayout() {
        let currentAnswer = UITextField()

        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)

        NSLayoutConstraint.activate([
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel!.bottomAnchor, constant: 20)
        ])
        self.currentAnswer = currentAnswer
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
                letterBtn.layer.borderWidth = 0.3
                letterBtn.layer.borderColor = UIColor.lightGray.cgColor

                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterBtn.frame = frame
                buttonsView.addSubview(letterBtn)
                letterButtons.append(letterBtn)
            }
        }
    }
}
