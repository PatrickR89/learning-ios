//
//  ViewController.swift
//  project7codeOnly
//
//  Created by Patrick on 06.06.2022..
//

import UIKit

class ViewController: UIViewController {

    let tableView = UITableView()
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        view.backgroundColor = .white

        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }

        func parse(json: Data) {
            let decoder = JSONDecoder()

            if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
                petitions = jsonPetitions.results
                tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: "SinglePetition") else {
            fatalError("No cell")
        }
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "SinglePetition")

        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = DetailViewController()
        detailView.singleItem = petitions[indexPath.row]
        navigationController?.pushViewController(detailView, animated: true)
    }
}

extension ViewController {
    func configTableView () {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SinglePetition")
    }
}
