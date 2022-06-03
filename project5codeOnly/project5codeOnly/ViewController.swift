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
        present(alertController, animated: true)
    }
}
