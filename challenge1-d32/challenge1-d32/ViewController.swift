//
//  ViewController.swift
//  challenge1-d32
//
//  Created by Patrick on 06.06.2022..
//

import UIKit

class ViewController: UIViewController {

    let tableView = UITableView()
    var shoppingItems = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Shopping list"
        configTableView()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addItem))

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "trash"),
            style: .plain,
            target: self,
            action: #selector(cleanList))
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Item") else {
            fatalError("No cell")
        }

        cell.textLabel?.text = shoppingItems[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItems.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleRemoveItem(indexPath)
    }
}

extension ViewController {

    func configTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Item")
    }

    @objc func addItem() {
        let alertController = UIAlertController(title: "Enter new item", message: nil, preferredStyle: .alert)
        alertController.addTextField()

        let handleSubmit = UIAlertAction(title: "Submit", style: .default) {[weak self, weak alertController] _ in
            guard let item = alertController?.textFields?[0].text?.lowercased() else {return}
            self?.submit(item)
        }

        let handleCancel = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(handleSubmit)
        alertController.addAction(handleCancel)
        present(alertController, animated: true)
    }

    func submit(_ item: String) {
        shoppingItems.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    @objc func cleanList() {
        shoppingItems.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    func handleRemoveItem(_ indexPath: IndexPath) {

        let alertController = UIAlertController(
            title: "Remove",
            message: "Do you want to remove shopping item?",
            preferredStyle: .alert)

        let removeItem = UIAlertAction(
            title: "Remove",
            style: .default) {[weak self] _ in
            self?.shoppingItems.remove(at: indexPath[1])
            self?.tableView.reloadData()
        }

        let handleCancel = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(removeItem)
        alertController.addAction(handleCancel)

        present(alertController, animated: true)
    }
}
