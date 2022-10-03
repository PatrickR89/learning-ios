//
//  GameViewCell.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import UIKit

class GameViewCell: UICollectionViewCell {

    lazy var imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configImageLayout() {
        contentView.addSubview(imageView)
        contentView.layer.cornerRadius = 5
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 29

        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.9),
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.9)
        ])
    }

    func drawCard(with card: GameCard) {
        imageView.image = UIImage(systemName: card.image)
        imageView.tintColor = card.color
        print(card.id)
    }
}
