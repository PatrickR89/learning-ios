//
//  ViewController.swift
//  Project2CodeOnly
//
//  Created by Patrick on 25.05.2022..
//

import UIKit

class ViewController: UIViewController {

    let button1 = UIButton(type: .custom)
    let button2 = UIButton(type: .custom)
    let button3 = UIButton(type: .custom)

    var countries = [String]()
    var score = 0
    var correctAnswer = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(button1)
        customizeButton(button1)

        view.addSubview(button2)
        customizeButton(button2)

        view.addSubview(button3)
        customizeButton(button3)


        countries += ["estonia",
                      "france",
                      "germany",
                      "ireland",
                      "italy",
                      "monaco",
                      "nigeria",
                      "poland",
                      "russia",
                      "spain",
                      "uk",
                      "us"]
        askQuestion()
    }
}

// MARK: Buttons implementation

extension ViewController {

    func customizeButton(_ button: UIButton) {
        button.setTitle("", for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 100),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        switch button {
        case button1:
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
            button.tag = 0
        case button2:
            button.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 40).isActive = true
            button.tag = 1
        case button3:
            button.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 40).isActive = true
            button.tag = 2
        default:
            print("Missing button id")
        }
    }
}

// MARK: Implement functionality

extension ViewController {
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = countries[correctAnswer].uppercased()
    }

    @objc func buttonAction(_ sender: UIButton!) {
        var title: String

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }

        let alertController = UIAlertController(title: title,
                                                message: "Your current score is: \(score)",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))

        present(alertController, animated: true)
    }

}
