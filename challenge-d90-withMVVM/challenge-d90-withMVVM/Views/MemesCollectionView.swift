//
//  MemesCollectionView.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit
import RealmSwift

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

    private var notificationToken: NotificationToken?

    init(with viewModel: MemesViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        notificationToken?.invalidate()
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

        viewModel.observeSingleMeme { meme in
            self.delegate?.memesCollectionView(self, didRegisterUpdate: meme)
        }

        notificationToken = viewModel.memes.observe { [weak self] (changes) in
            DispatchQueue.main.async {
                guard let collectionView = self?.collectionView else {return}

                switch changes {

                case .initial(_):
                    collectionView.reloadData()
                case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                    collectionView.performBatchUpdates {
                        collectionView.deleteItems(at: deletions.map({IndexPath(item: $0, section: 0)}))
                        collectionView.insertItems(at: insertions.map({IndexPath(item: $0, section: 0)}))
                        collectionView.reloadItems(at: modifications.map({IndexPath(item: $0, section: 0)}))
                    }
                case .error(_):
                    print("error")
                }
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
            let meme = viewModel.findMeme(at: indexPath.item)
            cell.setupData(load: meme)
            return cell
        }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.returnMemesCount()
    }
}

extension MemesCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        let meme = viewModel.findMeme(at: index)
        delegate?.memesCollectionView(self, didSelectCellWith: meme, at: index)
    }
}
