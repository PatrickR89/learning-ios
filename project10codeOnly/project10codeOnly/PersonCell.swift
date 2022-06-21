//
//  PersonCell.swift
//  project10codeOnly
//
//  Created by Patrick on 14.06.2022..
//

import UIKit

class PersonCell: UICollectionViewCell {
    let image = UIImageView()
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupContentView()
        setupImageView()
        setupLabelView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PersonCell {

    func setupContentView() {
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 7
    }

    func setupImageView() {
        contentView.addSubview(image)

        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        image.layer.cornerRadius = 3

        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            image.widthAnchor.constraint(equalToConstant: 120),
            image.heightAnchor.constraint(equalToConstant: 120)
        ])
    }

    func setupLabelView() {
        contentView.addSubview(label)
        label.numberOfLines = 2
        label.text = "label"
        label.textAlignment = .center

        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            label.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func setup(with person: Person) {
        label.text = person.name
        let path = FileManager.default.getFilePath(person.image)
        image.image = UIImage(contentsOfFile: path.path)
    }
}
