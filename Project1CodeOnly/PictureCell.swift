//
//  PictureCell.swift
//  Project1CodeOnly
//
//  Created by Patrick on 24.05.2022..
//

import UIKit

class PictureCell: UITableViewCell {
    
    var label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label)
        
        configureLabel()
        setLabelConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureLabel() {
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
    }
    
    func setLabelConstraints () {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
}
