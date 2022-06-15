//
//  ViewController.swift
//  project10codeOnly
//
//  Created by Patrick on 14.06.2022..
//

import UIKit

class ViewController: UIViewController {

    let collectionLayout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: type(of: collectionLayout).init())
        return collectionView
    }()
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNew))
    }
}
