//
//  ViewController.swift
//  project10codeOnly
//
//  Created by Patrick on 14.06.2022..
//

import UIKit

class ViewController: UIViewController {

    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNew))
    }
}
