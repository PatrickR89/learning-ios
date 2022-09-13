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

    private var imageName: String = "" {
        didSet {
            delegate?.memeVCViewModel(self, didSaveImageWithName: imageName)
        }
    }

    weak var delegate: MemeVCViewModelDelegate?

    private var observer: ((Bool) -> Void)?

    private func valueDidChange() {
        guard let observer = self.observer else {return}
        observer(isImageLoaded)
    }
}

extension MemeVCViewModel {

    func observeImageState(_ closure: @escaping (Bool) -> Void) {
        self.observer = closure
        valueDidChange()
    }

    func updateIsImageLoaded(imageDidLoad isImageLoaded: Bool) {
        self.isImageLoaded = isImageLoaded
    }

    func addAlertController(in viewController: UIViewController) -> UIAlertController {
        let alertController = UIAlertController().createAlertController(in: viewController, with: self)
        return alertController
    }

    func addDeletionAlertController(in viewController: UIViewController) -> UIAlertController {
        let alertController = UIAlertController().createDeletionAlertController(in: viewController, with: self)
        return alertController
    }

    func createImagePickerController( in viewController:
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

    func editImage(meme: Meme, text: String, at textPosition: Position) {

        switch textPosition {
        case .top:
            self.delegate?.memeVCViewModel(self, didEditMeme: meme, with: text, at: textPosition)
        case .bottom:
            self.delegate?.memeVCViewModel(self, didEditMeme: meme, with: text, at: textPosition)
        }
    }

    func shareMeme(in viewController: MemeViewController) -> UIAlertController {
        let alertController = UIAlertController(
            title: "Enter name",
            message: "Name your meme before you send it",
            preferredStyle: .alert)

        alertController.addTextField()

        let titleAction = UIAlertAction(title: "Send", style: .default) { [weak alertController, weak self] _ in
            print("init")
            guard let self = self,
                  let title = alertController?.textFields?[0].text else {return}
            let imagePath = FileManager.default.getFilePath(self.imageName)
            guard let image = UIImage(contentsOfFile: imagePath.path) else {return}
            print("lets")
            let activityController = UIActivityViewController(activityItems: [image, title], applicationActivities: [])

            viewController.present(activityController, animated: true)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(titleAction)
        alertController.addAction(cancelAction)

        return alertController
    }
}
