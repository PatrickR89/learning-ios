//
//  GameViewCell.swift
//  project-99
//
//  Created by Patrick on 23.09.2022..
//

import UIKit

class GameViewCell: UICollectionViewCell {

    var imageName = "" {
        didSet {
            configImageLayout()
        }
    }

    lazy var imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configCellImage(_ inputName: String) {
        imageName = inputName
    }

    func configImageLayout() {
        contentView.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: imageName)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.9),
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.9)
        ])
    }
}