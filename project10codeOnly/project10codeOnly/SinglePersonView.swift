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
    var textField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupImageView()
        setupText()
        // Do any additional setup after loading the view.
    }

    func setupImageView() {

        view.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor(white: 1, alpha: 0.5).cgColor
        imageView.layer.cornerRadius = 5

        let path = FileManager.default.getImagePath(singlePerson.image)
        imageView.image = UIImage(contentsOfFile: path.path)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 180),
            imageView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }

    func setupText() {
        view.addSubview(textField)

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.text = singlePerson.name
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textColor = .white
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
}
