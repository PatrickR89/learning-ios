//
//  ViewController.swift
//  project7codeOnly
//
//  Created by Patrick on 06.06.2022..
//

import UIKit

class ListViewController: UIViewController {

    private let configuration: ListViewControllerConfig
    let tableView = UITableView()
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    var urlString: String = "https://www.hackingwithswift.com/samples/petitions-1.json"
    var searchString: String = ""

    required init(configuration: ListViewControllerConfig) {
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        view.backgroundColor = .white

        guard let url = URL(string: configuration.url),
              let data = try? Data(contentsOf: url) else { return }
        parse(json: data)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: "SinglePetition") else {
            fatalError("No cell")
        }
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "SinglePetition")

        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body

        cell.backgroundColor = configuration.cellBackgroundColor

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = DetailViewController(singleItem: filteredPetitions[indexPath.row])
        navigationController?.pushViewController(detailView, animated: true)
    }
}

extension ListViewController {

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

    func showError() {
        let alertController = UIAlertController(
            title: "Loading error",
            message: "Unfortunately there was an issue loading the feed. Check your connection and try again",
            preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()

        guard let jsonPetitions = try? decoder.decode(Petitions.self, from: json) else {return}
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.reloadData()
            return
    }
}

extension ListViewController: BarActionProvider {
    func viewAPI() {
        let alertController = UIAlertController(title: "Source", message: urlString, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))

        present(alertController, animated: true)
    }

    func filterItems() {
        let alertController = UIAlertController(title: "Find", message: nil, preferredStyle: .alert)
        alertController.addTextField()

        let handleSearch = UIAlertAction(title: "Search", style: .default) { [weak self, weak alertController] _ in
            guard let searchItem = alertController?.textFields?[0].text?.lowercased() else {return}
            self?.searchString = searchItem
            self?.filterPetitions(searchItem)
            self?.tableView.reloadData()
        }

        let resetSearch = UIAlertAction(title: "Reset", style: .default) { [weak self] _ in
            self?.searchString = ""
            if let petitions = self?.petitions {
                self?.filteredPetitions = petitions
            }
            self?.tableView.reloadData()
        }

        alertController.addAction(handleSearch)
        alertController.addAction(resetSearch)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alertController, animated: true)
    }

    func filterPetitions (_ search: String) {
        filteredPetitions = []

        if search == "" {filteredPetitions = petitions}

        for petition in petitions {
            if petition.title.lowercased().contains(search) {
                filteredPetitions.append(petition)
            }
        }
    }
}
