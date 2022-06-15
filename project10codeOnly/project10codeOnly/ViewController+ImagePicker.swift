//
//  ViewController+ImagePicker.swift
//  project10codeOnly
//
//  Created by Patrick on 14.06.2022..
//

import UIKit

extension ViewController: UIImagePickerControllerDelegate {

    func getLastIndexPath () {
        let lastSection = collectionView.numberOfSections - 1
        let lastIndex = collectionView.numberOfItems(inSection: lastSection) - 1

        lastIndexPath = IndexPath(item: lastIndex, section: lastSection)
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

            let newIndexPath = IndexPath(item: lastIndexPath.item + 1, section: lastIndexPath.section)
            collectionView.insertItems(at: [newIndexPath])
            collectionView.reloadItems(at: [newIndexPath])

            dismiss(animated: true)
        }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        return paths[0]
    }
}

extension ViewController: UINavigationControllerDelegate {

    @objc func addPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
}
