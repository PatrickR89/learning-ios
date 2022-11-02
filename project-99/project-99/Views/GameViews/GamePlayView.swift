//
//  GamePlayView.swift
//  project-99
//
//  Created by Patrick on 24.10.2022..
//

import UIKit
import Combine

class GamePlayView: UIView {

    let viewModel: GamePlayViewModel
    let stopwatch: Stopwatch
    var cancellables = [AnyCancellable]()

    let remainingChancesLabel = UILabel()
    let timerTextLabel = UILabel()
    let timerCountLabel = UILabel()
    let gridView = GridLayoutView()

    init(with viewModel: GamePlayViewModel, and stopwatch: Stopwatch) {
        self.viewModel = viewModel
        self.stopwatch = stopwatch

        super.init(frame: .zero)
        self.bindPublishedElements()
        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
            $0.remainingChancesLabel.textColor = $1.textColor
            $0.timerTextLabel.textColor = $1.textColor
            $0.timerCountLabel.textColor = $1.textColor
            $0.reloadInputViews()
        }
    }

    deinit {
        cancellables.forEach {
            $0.cancel()
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
        viewModel.$turns
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] turns in
                if !turns.isActive {
                    self?.remainingChancesLabel.isHidden = true
                } else {
                    self?.remainingChancesLabel.text = "Remainig chances: \(turns.value)"
                }
            })
            .store(in: &cancellables)
    }
}

extension GamePlayView {
    func setupLevelLayout(_ level: Level) {

        appendViews([remainingChancesLabel, timerTextLabel, timerCountLabel, gridView])

        remainingChancesLabel.text = "Remaning chances: 0"
        remainingChancesLabel.textAlignment = .center

        timerTextLabel.text = "Time:"
        timerCountLabel.text = "00.0"
        timerTextLabel.textAlignment = .right
        timerCountLabel.textAlignment = .right
        gridView.setupUI(with: viewModel.assignedCardsDeck, in: level)

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
            gridView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 30),
            gridView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            gridView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            gridView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
