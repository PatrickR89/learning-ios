//
//  GameView.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import UIKit

class GameView: UIView {

    let viewModel: GameViewModel

    lazy var collectionLayout: UICollectionViewFlowLayout = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        collectionLayout.minimumInteritemSpacing = 0
        collectionLayout.minimumLineSpacing = 0

        return collectionLayout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: collectionLayout)
        return collectionView
    }()

    init(with viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configCollectionViewLayout(for level: Level) {
        var dimensionDependance: Double
        switch level {
        case .veryEasy:
            dimensionDependance = 2.3
        case .easy:
            dimensionDependance = 3.12
        case .mediumHard:
            dimensionDependance = 4.3
        case .hard:
            dimensionDependance = 3.3
        case .veryHard:
            dimensionDependance = 4.3
        case .emotionalDamage:
            dimensionDependance = 4.35
        }

        collectionLayout.itemSize = CGSize(
            width: self.frame.width / dimensionDependance,
            height: self.frame.width / dimensionDependance)
        
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.register(GameViewCell.self, forCellWithReuseIdentifier: "image")
        collectionView.delegate = self
        collectionView.dataSource = self

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ])
    }
}

extension GameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.countCardsLength()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "image",
                for: indexPath) as? GameViewCell else {fatalError("No cell!")}
            cell.configImageLayout()
            let card = viewModel.returnCardForIndex(at: indexPath.item)
            cell.drawCard(with: card)
            return cell
        }
}

extension GameView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
