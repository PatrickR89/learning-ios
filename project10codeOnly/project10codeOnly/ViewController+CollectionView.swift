//
//  ViewController+CollectionView.swift
//  project10codeOnly
//
//  Created by Patrick on 14.06.2022..
//

import UIKit

extension ViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "Person",
                for: indexPath) as? PersonCell else {
                fatalError("No cell!")
            }

            cell.setup(with: people[indexPath.item])
            return cell
        }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
}

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let personView = SinglePersonView()

        personView.singlePerson = people[indexPath.item]

        navigationController?.pushViewController(personView, animated: true)
//        let alertController = UIAlertController(title: "Rename", message: nil, preferredStyle: .alert)
//        alertController.addTextField()
//        let rename = UIAlertAction(title: "OK", style: .default) { [weak self, weak alertController] _ in
//            guard let newName = alertController?.textFields?[0].text else {return}
//            person.name = newName
//            self?.collectionView.reloadItems(at: [indexPath])
//        }
//        alertController.addAction(rename)
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//
//        present(alertController, animated: true)
    }
}
