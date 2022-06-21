//
//  PeopleViewController.swift
//  project10codeOnly
//
//  Created by Patrick on 14.06.2022..
//

import UIKit

class PeopleViewController: UIViewController {

    lazy var collectionLayout: UICollectionViewFlowLayout = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        collectionLayout.estimatedItemSize.height = 180
        collectionLayout.estimatedItemSize.width = 140
        return collectionLayout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: collectionLayout)
        return collectionView
    }()

    var people = [Person]()

    let peopleFile = FileManager().getFilePath("peopleJSON.txt")

    var imageInsertIndex = IndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        decodePeople()

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewPerson))

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(encodePeople))

    }

    @objc func encodePeople() {
        do {
            let encodeToJSON = JSONEncoder()
            let peopleJSON = try encodeToJSON.encode(people)
            print(peopleJSON)
            try peopleJSON.write(to: peopleFile, options: .atomic)
        } catch {
            print("an error occured \(error)")
        }

    }

    func decodePeople() {
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
