//
//  MemeVCViewModel.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

class MemeVCViewModel {

    private var isImageLoaded: Bool = false {
        didSet {
            valueDidChange()
        }
    }

    private var isEditingEnabled: Bool = false {
        didSet {
            editStateDidChange()
        }
    }

    private var imageName: String = "" {
        didSet {
            delegate?.memeVCViewModel(self, didSaveImageWithName: imageName)
        }
    }

    private var shareImageName: String = ""

    weak var delegate: MemeVCViewModelDelegate?

    private var observer: ((Bool) -> Void)?
    private var editObserver: ((Bool) -> Void)?

    private func valueDidChange() {
        guard let observer = self.observer else {return}
        observer(isImageLoaded)
    }

    private func editStateDidChange() {
        guard let editObserver = self.editObserver else {return}
        editObserver(isEditingEnabled)
    }
}

extension MemeVCViewModel {

    func observeImageState(_ closure: @escaping (Bool) -> Void) {
        self.observer = closure
        valueDidChange()
    }

    func observeEditState(_ closure: @escaping (Bool) -> Void) {
        self.editObserver = closure
        editStateDidChange()
    }

    func updateIsImageLoaded(imageDidLoad isImageLoaded: Bool) {
        self.isImageLoaded = isImageLoaded
    }

    func updateEditState(editIsEnabled isEditEnabled: Bool) {
        self.isEditingEnabled = isEditEnabled
    }

    func addShareAlertController(in viewController: UIViewController) -> UIAlertController {
        let alertController = UIAlertController().createShareAlertController(in: viewController, with: self)
        return alertController
    }

    func addEditAlertController(in viewController: UIViewController) -> UIAlertController {
        let alertController = UIAlertController().createEditAlertController(in: viewController, with: self)
        return alertController
    }

    func addDeletionAlertController(in viewController: UIViewController) -> UIAlertController {
        let alertController = UIAlertController().createDeletionAlertController(in: viewController, with: self)
        return alertController
    }

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

    func editImage(text: String, at textPosition: Position) {
        self.delegate?.memeVCViewModel(self, didEditText: text, at: textPosition)
    }

    func imageNameRequested() -> String {
        return shareImageName
    }

    func imageNameLoaded(imageName: String) {
        self.shareImageName = imageName
    }
}
