//
//  ViewController.swift
//  project3CodeOnly
//
//  Created by Patrick on 31.05.2022..
//

import UIKit

class ViewController: UIViewController {

    var countries = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Countries"
        let tableView = UITableView()

        countries += [
            "estonia",
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

        configTableView()
        view.backgroundColor = .white

        func configTableView() {
            view.addSubview(tableView)
            setTableViewDelegates()
            tableView.rowHeight = 50
            tableView.register(FlagCell.self, forCellReuseIdentifier: "FlagCell")

            tableView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }

        func setTableViewDelegates() {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableCell = tableView.dequeueReusableCell(withIdentifier: "FlagCell") as? FlagCell else {
            fatalError("Wrong cell type")
        }
        tableCell.label.text = countries[indexPath.row]
        return tableCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
}
