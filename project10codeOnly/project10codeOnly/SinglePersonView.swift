//
//  SinglePersonView.swift
//  project10codeOnly
//
//  Created by Patrick on 18.06.2022..
//

import UIKit

class SinglePersonView: UIViewController {

    var singlePerson = Person(name: "", image: "")
    var imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(singlePerson)
        view.backgroundColor = .gray
        setupImageView()
        // Do any additional setup after loading the view.
    }

    func setupImageView() {

        view.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor(white: 0, alpha: 0.5).cgColor
        imageView.layer.cornerRadius = 3

        let path = FileManager.default.getImagePath(singlePerson.image)
        imageView.image = UIImage(contentsOfFile: path.path)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 180),
            imageView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
}
