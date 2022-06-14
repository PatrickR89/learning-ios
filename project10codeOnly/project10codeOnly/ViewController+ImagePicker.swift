//
//  ViewController+ImagePicker.swift
//  project10codeOnly
//
//  Created by Patrick on 14.06.2022..
//

import UIKit

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @objc func addNew() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

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
            collectionView.reloadData()

            dismiss(animated: true)
        }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        return paths[0]
    }
}
