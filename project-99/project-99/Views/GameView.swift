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

    let remainingChancesLabel = UILabel()

    init(with viewModel: GameViewModel) {
        self.viewModel = viewModel

        super.init(frame: .zero)
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
        self.addSubview(remainingChancesLabel)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        remainingChancesLabel.translatesAutoresizingMaskIntoConstraints = false

        collectionView.register(GameViewCell.self, forCellWithReuseIdentifier: "image")
        collectionView.delegate = self
        collectionView.dataSource = self

        remainingChancesLabel.text = "Remaning chances: 0"
        remainingChancesLabel.textAlignment = .center

        NSLayoutConstraint.activate([
            remainingChancesLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            remainingChancesLabel.widthAnchor.constraint(equalTo: self.layoutMarginsGuide.widthAnchor),
            collectionView.topAnchor.constraint(equalTo: remainingChancesLabel.bottomAnchor, constant: 5),
            collectionView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ])
    }

    private func bindObservers() {

        viewModel.observeCardDeck { _ in
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }

        viewModel.observeRemainigTurns { isTurnsCountdown, turnsValue in
            DispatchQueue.main.async { [weak self] in
                if !isTurnsCountdown {
                    self?.remainingChancesLabel.isHidden = true
                } else {
                    self?.remainingChancesLabel.text = "Remainig chances: \(turnsValue)"
                }
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
