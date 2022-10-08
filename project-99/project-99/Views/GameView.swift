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
        self.viewModel.delegate = self
        self.bindObservers()
        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
            $0.collectionView.backgroundColor = $1.backgroundColor
            $0.reloadInputViews()
        }
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

    private func bindObservers() {
        viewModel.bindFirstCardObserver { firstCard in
            DispatchQueue.main.async { [weak self] in
                guard let itemIndex = self?.viewModel.returnIndexForCard(card: firstCard) else {return}
                let indexPath = IndexPath(item: itemIndex, section: 0)
                self?.collectionView.reloadItems(at: [indexPath])
            }
        }

        viewModel.bindSecondCardObserver { secondCard in
            DispatchQueue.main.async { [weak self] in
                guard let itemIndex = self?.viewModel.returnIndexForCard(card: secondCard) else {return}
                let indexPath = IndexPath(item: itemIndex, section: 0)
                self?.collectionView.reloadItems(at: [indexPath])
            }
        }
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
            cell.configCellBasicLayout()
            let card = viewModel.returnCardForIndex(at: indexPath.item)
            print(viewModel.keepCardRevealed(for: card))
            if viewModel.keepCardRevealed(for: card) {
                cell.revealCardFace(with: card)
            } else {
                cell.hideCardFace()
            }
            return cell
        }
}

extension GameView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let card = viewModel.returnCardForIndex(at: indexPath.item)
        viewModel.selectCard(card: card, at: indexPath.item)
    }
}

extension GameView: GameViewModelDelegate {
    func gameViewModel(_ viewModel: GameViewModel, didChangeCardSelectionAt index: Int) {
    }

    func gameViewModel(_ viewModel: GameViewModel, didPairCardAt index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.reloadItems(at: [indexPath])
    }
}
