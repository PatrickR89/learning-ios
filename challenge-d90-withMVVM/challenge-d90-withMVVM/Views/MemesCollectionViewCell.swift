//
//  MemesCollectionViewCell.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

class MemesCollectionViewCell: UICollectionViewCell {
    private var imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MemesCollectionViewCell {
    func setupUI() {
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 5

        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 170),
            imageView.heightAnchor.constraint(equalToConstant: 170),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

extension MemesCollectionViewCell {
    func setupData(load meme: Meme) {
        let path = FileManager.default.getFilePath(meme.image)
        let image = UIImage(contentsOfFile: path.path)
        imageView.image = image
    }
}
