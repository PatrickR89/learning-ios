//
//  ViewController+CollectionView.swift
//  project10codeOnly
//
//  Created by Patrick on 14.06.2022..
//

import UIKit

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

        /// - Tag: TwoColumn
        func createLayout() -> UICollectionViewLayout {
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(140),
                                                  heightDimension: .absolute(180))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(350),
                                                  heightDimension: .absolute(200))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            let spacing = CGFloat(10)
            group.interItemSpacing = .flexible(50)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
        }

        func configureHierarchy() {
//            collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
            collectionView.register(PersonCell.self, forCellWithReuseIdentifier: "Person")
            collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = .black
            view.addSubview(collectionView)

            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                collectionView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
                collectionView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor)
            ])
        }

//    func setupCollectionView() {
//
//        collectionView.register(PersonCell.self, forCellWithReuseIdentifier: "Person")
//        view.addSubview(collectionView)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.backgroundColor = .black
//
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
//            collectionView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
//            collectionView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor)
//        ])
//    }

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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]

        let alertController = UIAlertController(title: "Rename", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        let rename = UIAlertAction(title: "OK", style: .default) { [weak self, weak alertController] _ in
            guard let newName = alertController?.textFields?[0].text else {return}
            person.name = newName
            self?.collectionView.reloadItems(at: [indexPath])
        }
        alertController.addAction(rename)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alertController, animated: true)
    }
}
