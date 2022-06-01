//
//  DetailViewController.swift
//  Project1CodeOnly
//
//  Created by Patrick on 24.05.2022..
//

import UIKit

class DetailViewController: UIViewController {

    var imageView = UIImageView()
    var selectedImage: String?
    var pictureAmount: Int?
    var selectedImageIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = setTitle()

        let rightBarButtonSymbol = UIImage(systemName: "square.and.arrow.up.fill")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: rightBarButtonSymbol,
            style: .plain,
            target: self,
            action: #selector(shareImage))

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
            view.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }
    func setTitle () -> String {
        guard let index = selectedImageIndex,
              let amount = pictureAmount else {
            return "Nothing!"
        }
        return "Image \(index + 1) of \(amount)"
    }

    @objc func shareImage() {
        guard let imageTitle = selectedImage else {
            print("No title")
            return
        }

        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image")
            return
        }

        let activityController = UIActivityViewController(activityItems: [image, imageTitle], applicationActivities: [])
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
