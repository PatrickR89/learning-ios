//
//  ViewController+ImagePicker.swift
//  project10codeOnly
//
//  Created by Patrick on 14.06.2022..
//

import UIKit

extension ViewController: UIImagePickerControllerDelegate {

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            guard let image = info[.editedImage] as? UIImage else {return}
            let imageName = UUID().uuidString
            let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: imagePath)
            }

            let person = Person(name: "Unknown", image: imageName)
            people.append(person)

            getLastIndexPath()

            let newIndexPath = IndexPath(item: lastIndexPath.item + 1, section: lastIndexPath.section)
            collectionView.insertItems(at: [newIndexPath])

            dismiss(animated: true)
        }
}

extension ViewController: UINavigationControllerDelegate {
}
