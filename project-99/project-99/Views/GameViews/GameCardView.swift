//
//  GameCardView.swift
//  project-99
//
//  Created by Patrick on 24.10.2022..
//

import UIKit
import Combine

class GameCardView: UIView {

    lazy var imageView = UIImageView()
    lazy var backLabel = UILabel()
    var viewModel = GameCardViewModel()
    private var card: AnyCancellable?

    init() {
        super.init(frame: .zero)
        bindObserver()
        addTapFunctionality()
        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
            $0.backLabel.textColor = $1.textColor
        }
    }

    deinit {
        card?.cancel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addTapFunctionality() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleCardVisibility))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }

    private func bindObserver() {
        card = viewModel.$gameCard
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] card in
                guard let self = self else {return}

                if card.isVisible && !card.isPaired {
                    self.perform(#selector(self.showCard), with: nil)
                } else if card.isPaired {
                    self.perform(#selector(self.cardsPaired), with: nil)
                } else {
                    self.perform(#selector(self.hideCard), with: nil)
                }
            })
    }

    @objc func toggleCardVisibility() {
        if !viewModel.gameCard.isVisible && !viewModel.gameCard.isPaired {
            viewModel.cardFlipped()
        }
    }

    func configCellBasicLayout() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 2
        self.backgroundColor = .black
    }

    func setupCardUI(_ card: GameCard) {
        viewModel.setupCard(for: card)
        self.appendViews([imageView, backLabel])

        imageView.image = UIImage(systemName: card.image)
        imageView.tintColor = card.color
        backLabel.text = "MEMO"
        backLabel.textAlignment = .center
        backLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            backLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backLabel.heightAnchor.constraint(equalToConstant: 40),
            backLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }

    @objc func showCard() {
        let animation: UIView.AnimationOptions = .transitionFlipFromRight
        UIView.transition(with: self, duration: 0.3, options: animation, animations: { [weak self] in
            guard let self = self else {return}
            self.backLabel.isHidden = true
            self.imageView.isHidden = false
        })
    }

    @objc func hideCard() {
        let animation: UIView.AnimationOptions = .transitionFlipFromLeft
        UIView.transition(with: self, duration: 0.3, options: animation, animations: { [weak self] in
            guard let self = self else {return}
            self.imageView.isHidden = true
            self.backLabel.isHidden = false
        })
    }

    @objc func cardsPaired() {
        let animation: UIView.AnimationOptions = .transitionCrossDissolve
        UIView.transition(with: self, duration: 0.3, options: animation, animations: { [weak self] in
            guard let self = self else {return}
            self.backLabel.isHidden = true
            self.imageView.isHidden = false
            self.imageView.tintColor = .lightGray
        })
    }
}
