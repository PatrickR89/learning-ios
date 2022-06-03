//
//  ViewController.swift
//  project5codeOnly
//
//  Created by Patrick on 03.06.2022..
//

import UIKit

class ViewController: UIViewController {

    var allWords = [String]()
    var usedWords = [String]()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()

        let inputSymbol = UIImage(systemName: "character.cursor.ibeam")
        let restartSymbol = UIImage(systemName: "repeat")

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: inputSymbol,
            style: .plain,
            target: self,
            action: #selector(promptForAnswer))

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: restartSymbol,
            style: .plain,
            target: self,
            action: #selector(startGame))

        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }

        if allWords.isEmpty {
            allWords = ["Words not loaded"]
        }

        startGame()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Word") else {
            fatalError("No cell")
        }
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
}

extension ViewController {
    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    func configTableView() {
        view.addSubview(tableView)
        configTableViewDelegate()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Word")
    }

    func configTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    @objc func promptForAnswer() {
        let alertController = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        alertController.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak alertController] _ in
            guard let answer = alertController?.textFields?[0].text?.lowercased() else {return}
            self?.submit(answer)
        }

        alertController.addAction(submitAction)
        present(alertController, animated: true)
    }

    func submit(_ answer: String) {
        let tempAnswer = answer.lowercased()

        if isPossible(word: tempAnswer) {
            if isOriginal(word: tempAnswer) {
                if isReal(word: tempAnswer) {
                    if isLongEnough(word: tempAnswer) {
                        if isNewWord(word: tempAnswer) {
                            usedWords.insert(answer, at: 0)

                            let indexPath = IndexPath(row: 0, section: 0)
                            tableView.insertRows(at: [indexPath], with: .automatic)
                            return
                        } else {
                             errorHandling(
                                errorTitle: "\(tempAnswer) is starter word",
                                errorMessage: "Cannot use starter word")
                        }
                    } else {
                        errorHandling(
                            errorTitle: "Word too short",
                            errorMessage: "Enter a word at least 3 characters long")
                    }
                } else {
                    errorHandling(
                        errorTitle: "Word not recognized",
                        errorMessage: "Use real valid word")
                }
            } else {
                errorHandling(
                    errorTitle: "Word already used",
                    errorMessage: "Enter a new original word")
            }
        } else {
            guard let title = title else {return}

            errorHandling(
                errorTitle: "Word not possible",
                errorMessage: "Cannot spell that from \(title)")
        }
    }

    func isPossible(word: String) -> Bool {

        guard var tempWord = title?.lowercased() else {return false}

        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }

        return true
    }

    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }

    func isReal(word: String) -> Bool {

        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en")

        return misspelledRange.location == NSNotFound
    }

    func isLongEnough(word: String) -> Bool {
        if word.count < 3 {
            return false
        }

        return true
    }

    func isNewWord(word: String) -> Bool {
        return word != title
    }

    func errorHandling(errorTitle: String, errorMessage: String) {
        let errorController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        errorController.addAction(UIAlertAction(title: "OK", style: .default))
        present(errorController, animated: true)
    }
}
