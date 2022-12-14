//
//  FlagCell.swift
//  project3CodeOnly
//
//  Created by Patrick on 31.05.2022..
//

import UIKit

class FlagCell: UITableViewCell {

    var label = UILabel()
    var cellImage = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(label)
        addSubview(cellImage)

        configureLabel()
        setLabelConstraints()
        configImage()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FlagCell {

    func configureLabel() {
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
    }

    func setLabelConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1)
        ])
    }

    func configImage() {
        cellImage.layer.borderWidth = 0.5
        cellImage.layer.borderColor = UIColor.black.cgColor
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            cellImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellImage.widthAnchor.constraint(equalToConstant: 50),
            cellImage.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
