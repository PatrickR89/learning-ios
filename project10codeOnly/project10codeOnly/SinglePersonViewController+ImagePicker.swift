//
//  PeopleViewController+ImagePicker.swift
//  project10codeOnly
//
//  Created by Patrick on 14.06.2022..
//

import UIKit

extension SinglePersonViewController: UIImagePickerControllerDelegate {

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            guard let image = info[.editedImage] as? UIImage else {return}
            let imageName = UUID().uuidString
            let imagePath = FileManager.default.getFilePath(imageName)

            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: imagePath)
            }
            print(imagePath)

            singlePerson.image = imageName
            delegate?.changeImage(image: imageName, indexPath: indexPath)
            setupImageInImageView()

            dismiss(animated: true)
        }
}

extension SinglePersonViewController: UINavigationControllerDelegate {
}
