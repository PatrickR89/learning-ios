//
//  GameViewCell.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import UIKit
import Combine

class GameViewCell: UICollectionViewCell {

    lazy var imageView = UIImageView()
    lazy var backLabel = UILabel()
    var viewModel = GameViewCellViewModel()
    var image: AnyCancellable?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        bindObserver()
        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
            $0.backLabel.textColor = $1.textColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bindObserver() {
        image = viewModel.$image
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] image in
                self?.imageView.image = image
                if image != nil {
                    self?.perform(#selector(self?.showCard), with: nil)
                } else {
                    self?.perform(#selector(self?.hideCard), with: nil)
                }
            })
    }

    func configCellBasicLayout() {
        contentView.layer.cornerRadius = 5
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 2
    }

    func setupUI(with card: GameCard) {
        contentView.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = card.color
        imageView.image = UIImage(systemName: card.image)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.9),
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.9)
        ])

        contentView.addSubview(backLabel)
        backLabel.translatesAutoresizingMaskIntoConstraints = false

        backLabel.text = "MEMO"
        backLabel.textAlignment = .center

        NSLayoutConstraint.activate([
            backLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            backLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            backLabel.heightAnchor.constraint(equalToConstant: 40),
            backLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }

    @objc func showCard() {
        let animation: UIView.AnimationOptions = .transitionFlipFromRight
        UIView.transition(with: self.contentView, duration: 0.5, options: animation, animations: { [weak self] in
            guard let self = self else {return}
            self.backLabel.isHidden = true
            self.imageView.isHidden = false
        })

    }

    @objc func hideCard() {
        let animation: UIView.AnimationOptions = .transitionFlipFromLeft
        UIView.transition(with: self.contentView, duration: 0.5, options: animation, animations: { [weak self] in
            guard let self = self else {return}
            self.imageView.isHidden = true
            self.backLabel.isHidden = false
        })

    }

    func showCardVisual(for card: GameCard) {
        imageView.tintColor = card.color
        imageView.image = UIImage(systemName: card.image)
        viewModel.setupImageName(card.image)
    }

    func hideCardVisual() {
        viewModel.removeImage()
    }
}
