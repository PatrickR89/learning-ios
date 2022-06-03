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

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(promptForAnswer))

        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }

        if allWords.isEmpty {
            allWords = ["Words not loaded"]
        }

        startGame()

        view.backgroundColor = .gray
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
    func startGame() {
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
            guard let answer = alertController?.textFields?[0].text else {return}
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
                    usedWords.insert(answer, at: 0)

                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                }
            }
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
}
