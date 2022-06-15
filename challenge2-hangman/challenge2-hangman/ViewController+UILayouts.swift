//
//  ViewController+UILayouts.swift
//  challenge2-hangman
//
//  Created by Patrick on 13.06.2022..
//

import UIKit

extension ViewController {

    func setupScoreLabel() {
        scoreLabel.text = "Score: 0"
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        view.addSubview(scoreLabel)

        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }

    func setupTriesLabel() {
        triesLabel.text = "Tries: 7"
        triesLabel.translatesAutoresizingMaskIntoConstraints = false
        triesLabel.textAlignment = .left
        view.addSubview(triesLabel)

        NSLayoutConstraint.activate([
            triesLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            triesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        ])
    }

    func setupAnswerLabel() {
        answer.text = "_______"
        answer.translatesAutoresizingMaskIntoConstraints = false
        answer.textAlignment = .center
        view.addSubview(answer)

        NSLayoutConstraint.activate([
            answer.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 30),
            answer.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func setupCharacterInput() {
        characterInput.translatesAutoresizingMaskIntoConstraints = false
        characterInput.textAlignment = .center
        characterInput.font = UIFont.systemFont(ofSize: 44)
        characterInput.layer.borderWidth = 1
        characterInput.layer.borderColor = UIColor.lightGray.cgColor
        characterInput.delegate = self
        view.addSubview(characterInput)

        NSLayoutConstraint.activate([
            characterInput.topAnchor.constraint(equalTo: answer.bottomAnchor, constant: 10),
            characterInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterInput.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setupWrongAnswerLayout() {
        wrongAnswersLabel.text = "Wrong tries:"
        wrongAnswersLabel.translatesAutoresizingMaskIntoConstraints = false
        wrongAnswersLabel.numberOfLines = 1
        view.addSubview(wrongAnswersLabel)

        NSLayoutConstraint.activate([
            wrongAnswersLabel.topAnchor.constraint(equalTo: characterInput.bottomAnchor, constant: 40),
            wrongAnswersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.9),
            wrongAnswersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
