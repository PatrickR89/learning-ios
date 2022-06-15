//
//  ViewController.swift
//  project10codeOnly
//
//  Created by Patrick on 14.06.2022..
//

import UIKit

class ViewController: UIViewController {

//    lazy var collectionLayout: UICollectionViewFlowLayout = {
//        let collectionLayout = UICollectionViewFlowLayout()
//        collectionLayout.scrollDirection = .vertical
//        collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        return collectionLayout
//    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: createLayout())
        return collectionView
    }()

    var people = [Person]()

    var lastIndexPath = IndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()

//        setupCollectionView()
        configureHierarchy()
        getLastIndexPath()

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addPerson))
    }
}
