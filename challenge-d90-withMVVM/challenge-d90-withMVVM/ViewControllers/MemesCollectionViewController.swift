//
//  MemesCollectionViewController.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

class MemesCollectionViewController: UIViewController {

    let memesCollectionView: MemesCollectionView

    init() {
        self.memesCollectionView = MemesCollectionView()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension MemesCollectionViewController {
    func setupUI() {
        view.addSubview(memesCollectionView)
        memesCollectionView.frame = view.bounds
    }
}
