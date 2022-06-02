//
//  DetailViewController.swift
//  project3CodeOnly
//
//  Created by Patrick on 01.06.2022..
//

import UIKit

class DetailViewController: UIViewController {

    var imageView = UIImageView()
    var countryName = UILabel()
    var selectedImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let loadImage = selectedImage {
            imageView.image = UIImage(named: loadImage)
            view.addSubview(imageView)
            imageView.layer.borderWidth = 0.5
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }

        if let loadTitle = selectedImage {
            countryName.text = loadTitle.uppercased()
            view.addSubview(countryName)
            countryName.textColor = .white
            countryName.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                countryName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                countryName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25)
            ])
        }

        let barButtonItemSymbol = UIImage(systemName: "paperplane.fill")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: barButtonItemSymbol,
            style: .plain,
            target: self,
            action: #selector(shareFlag))
    }

    @objc func shareFlag() {
        guard let flagName = selectedImage else {
            print("Flag name missing")
            return
        }

        guard let flagImage = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("Flag image missing")
            return
        }

        let activityController = UIActivityViewController(
            activityItems: [flagImage, flagName],
            applicationActivities: [])
        activityController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activityController, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
