//
//  MemesCollectionViewController.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

class MemesCollectionViewController: UIViewController {

    let memesCollectionView: MemesCollectionView
    let memesViewModel = MemesViewModel()

    init() {
        self.memesCollectionView = MemesCollectionView(with: memesViewModel)
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
        memesCollectionView.delegate = self
    }
}

extension MemesCollectionViewController: MemesCollectionViewDelegate {
    func memesCollectionView(_ view: MemesCollectionView, didSelectCellWith meme: Meme, at index: Int) {
        let navController = UINavigationController()
        let viewController = MemeViewController(memeViewModel: memesViewModel.memeViewModel)

        navController.viewControllers = [viewController]
        present(navController, animated: true)
    }
}