//
//  ImageViewModel.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

class ImageViewModel {

    private var imageName: String = "" {
        didSet {
            delegate?.imageViewModel(self, didSaveImageWithName: imageName)
        }
    }

    weak var delegate: ImageViewModelDelegate?

    func createImagePickerController(
        in viewController:
        UIViewController &
        UIImagePickerControllerDelegate &
        UINavigationControllerDelegate) -> UIImagePickerController {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.delegate = viewController
            return imagePicker
        }

    func createNewImage(image: UIImage) {
        let newImageName = UUID().uuidString
        let newImagePath = FileManager.default.getFilePath(newImageName)

        if let jpegData = image.jpegData(compressionQuality: 0.5) {
            try? jpegData.write(to: newImagePath)
        }

        imageName = newImageName
    }
}
