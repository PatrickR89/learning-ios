//
//  PeopleViewController+Methods.swift
//  project10codeOnly
//
//  Created by Patrick on 15.06.2022..
//

import UIKit

extension PeopleViewController {

    func setupCollectionView() {

        collectionView.register(PersonCell.self, forCellWithReuseIdentifier: "Person")
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor)
        ])
    }

    @objc func addNewPerson() {
        let person = Person(name: "", image: "")
        people.append(person)
        let newIndexPath = IndexPath(item: people.count - 1, section: collectionView.numberOfSections - 1)
        collectionView.insertItems(at: [newIndexPath])
        let singlePersonView = SinglePersonViewController(singlePerson: person, indexPath: newIndexPath)
        singlePersonView.delegate = self
        navigationController?.pushViewController(singlePersonView, animated: true)
    }

    @objc func encodeAndSavePeople() {
        do {
            let encodeToJSON = JSONEncoder()
            let peopleJSON = try encodeToJSON.encode(people)
            print(peopleJSON)
            try peopleJSON.write(to: peopleFile, options: .atomic)
        } catch {
            print("an error occured \(error)")
        }

    }

    func loadAndDecodePeople() {
        do {
            let decodeFromJSON = JSONDecoder()
            let response = try String(contentsOf: peopleFile)
            let data = Data(response.utf8)
            people = try decodeFromJSON.decode([Person].self, from: data)
        } catch {
            print("Error \(error)")
        }
    }
}

extension PeopleViewController: SinglePersonViewDelegate {
    func changeSingleName(name: String, indexPath: IndexPath) {
        people[indexPath.item].name = name
        collectionView.reloadItems(at: [indexPath])
    }

    func changeImage(image: String, indexPath: IndexPath) {
        people[indexPath.item].image = image
        collectionView.reloadItems(at: [indexPath])
    }
}
