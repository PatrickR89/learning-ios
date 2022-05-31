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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
