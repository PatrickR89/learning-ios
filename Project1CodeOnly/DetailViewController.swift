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
        // Do any additional setup after loading the view.
    }
    func setTitle () -> String{
         return "Image \(selectedImageIndex! + 1) of \(pictureAmount!)"

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
