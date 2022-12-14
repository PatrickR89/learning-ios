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
        loadAndDecodePeople()

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewPerson))

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(encodeAndSavePeople))
    }
}
