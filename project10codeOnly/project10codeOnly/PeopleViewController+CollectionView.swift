//
//  ViewController+CollectionView.swift
//  project10codeOnly
//
//  Created by Patrick on 14.06.2022..
//

import UIKit

extension PeopleViewController: UICollectionViewDataSource {

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

extension PeopleViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let personView = SinglePersonViewController()
        personView.delegate = self

        personView.singlePerson = people[indexPath.item]
        personView.indexPath = indexPath

        navigationController?.pushViewController(personView, animated: true)
    }
}
