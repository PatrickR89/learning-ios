//
//  MemesCollectionView.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

class MemesCollectionView: UIView {
    lazy var collectionLayout: UICollectionViewFlowLayout = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        collectionLayout.estimatedItemSize.height = 180
        collectionLayout.estimatedItemSize.width = 180
        return collectionLayout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        return collectionView
    }()

    weak var delegate: MemesCollectionViewDelegate?

    private var viewModel: MemesViewModel

    init(with viewModel: MemesViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MemesCollectionView {
    func setupUI() {
        collectionView.register(MemesCollectionViewCell.self, forCellWithReuseIdentifier: "MemeCell")
        self.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    func setupBindings() {
        viewModel.observeMemesState { memes in
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
                DataStorage.shared.saveFile(save: memes)
            }
        }
    }
}

extension MemesCollectionView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MemeCell",
            for: indexPath) as? MemesCollectionViewCell else {fatalError("ERROR: Cell not found")}
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.returnMemesCount()
    }
}

extension MemesCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meme = viewModel.findMeme(at: indexPath.item)
        delegate?.memesCollectionView(self, didSelectCellWith: meme, at: indexPath.item)
    }
}
