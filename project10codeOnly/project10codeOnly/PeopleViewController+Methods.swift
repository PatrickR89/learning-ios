//
//  ViewController+Methods.swift
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

    @objc func addPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension PeopleViewController: SinglePersonViewDelegate {
    func changeSingleName(name: String, indexPath: IndexPath) {
        people[indexPath.item].name = name
        collectionView.reloadItems(at: [indexPath])
    }
}
