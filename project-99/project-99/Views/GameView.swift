//
//  GameView.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import UIKit
import Combine

class GameView: UIView {

    let viewModel: GameViewModel
    let stopwatch: Stopwatch
    var cancellables = [AnyCancellable]()

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
    let timerTextLabel = UILabel()
    let timerCountLabel = UILabel()

    init(with viewModel: GameViewModel, and stopwatch: Stopwatch) {
        self.viewModel = viewModel
        self.stopwatch = stopwatch

        super.init(frame: .zero)
        self.bindObservers()
        self.bindPublishedElements()
        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
            $0.collectionView.backgroundColor = $1.backgroundColor
            $0.remainingChancesLabel.textColor = $1.textColor
            $0.timerTextLabel.textColor = $1.textColor
            $0.timerCountLabel.textColor = $1.textColor
            $0.reloadInputViews()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bindPublishedElements() {

        stopwatch.$timeString
            .receive(on: DispatchQueue.main)
            .assign(to: \.text!, on: timerCountLabel)
            .store(in: &cancellables)
        stopwatch.$isTimerOff
            .receive(on: DispatchQueue.main)
            .assign(to: \.isHidden, on: timerCountLabel)
            .store(in: &cancellables)
        stopwatch.$isTimerOff
            .receive(on: DispatchQueue.main)
            .assign(to: \.isHidden, on: timerTextLabel)
            .store(in: &cancellables)
        viewModel.$cardOneIndex
            .sink(receiveValue: { [weak self] indexPath in
                guard let indexPath = indexPath else {return}
                DispatchQueue.main.async {
                    self?.collectionView.reloadItems(at: [indexPath])
                }
            })
            .store(in: &cancellables)
        viewModel.$cardTwoIndex
            .sink(receiveValue: { [weak self] indexPath in
                guard let indexPath = indexPath else {return}
                DispatchQueue.main.async {
                    self?.collectionView.reloadItems(at: [indexPath])
                }
            })
            .store(in: &cancellables)
    }
}

extension GameView {
    func configCollectionViewLayout(for level: Level) {
        var dimensionDependance: Double
        switch level {
        case .veryEasy:
            dimensionDependance = 2.3
        case .easy:
            dimensionDependance = 3.3
        case .mediumHard:
            dimensionDependance = 4.3
        case .hard:
            dimensionDependance = 3.5
        case .veryHard:
            dimensionDependance = 4.3
        case .emotionalDamage:
            dimensionDependance = 4.55
        }

        collectionLayout.itemSize = CGSize(
            width: self.frame.width / dimensionDependance,
            height: self.frame.width / dimensionDependance)

        self.addSubview(collectionView)
        self.addSubview(remainingChancesLabel)
        self.addSubview(timerTextLabel)
        self.addSubview(timerCountLabel)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        remainingChancesLabel.translatesAutoresizingMaskIntoConstraints = false
        timerTextLabel.translatesAutoresizingMaskIntoConstraints = false
        timerCountLabel.translatesAutoresizingMaskIntoConstraints = false

        collectionView.register(GameViewCell.self, forCellWithReuseIdentifier: "image")
        collectionView.delegate = self
        collectionView.dataSource = self

        remainingChancesLabel.text = "Remaning chances: 0"
        remainingChancesLabel.textAlignment = .center

        timerTextLabel.text = "Time:"
        timerCountLabel.text = "00.0"
        timerTextLabel.textAlignment = .right
        timerCountLabel.textAlignment = .right

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            remainingChancesLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            remainingChancesLabel.widthAnchor.constraint(equalTo: self.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
            timerCountLabel.centerYAnchor.constraint(equalTo: remainingChancesLabel.centerYAnchor),
            timerCountLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -5),
            timerCountLabel.widthAnchor.constraint(equalTo: self.layoutMarginsGuide.widthAnchor, multiplier: 0.15),
            timerTextLabel.centerYAnchor.constraint(equalTo: remainingChancesLabel.centerYAnchor),
            timerTextLabel.trailingAnchor.constraint(equalTo: timerCountLabel.leadingAnchor, constant: -5),
            timerTextLabel.widthAnchor.constraint(equalTo: self.layoutMarginsGuide.widthAnchor, multiplier: 0.35),
            collectionView.topAnchor.constraint(equalTo: remainingChancesLabel.bottomAnchor, constant: 5),
            collectionView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ])
    }

    private func bindObservers() {

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
        return viewModel.cardsDeck.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "image",
                for: indexPath) as? GameViewCell else {fatalError("No cell!")}
            cell.configCellBasicLayout()
            let card = viewModel.cardsDeck[indexPath.item]
            cell.setupUI(with: card)
            cell.viewModel.flipCard(for: card)
            return cell
        }
}

extension GameView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectCard(at: indexPath.item)
    }
}
