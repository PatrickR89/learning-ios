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

    func editImage(meme: Meme, text: String, at textPosition: Position) {
       let imagePath = FileManager.default.getFilePath(meme.imageName)
       guard let image = UIImage(contentsOfFile: imagePath.path) else {return}

       let imageWithText = image.addMemeText(text: text, at: textPosition)
       if let jpegData = imageWithText.jpegData(compressionQuality: 0.5) {
           try? jpegData.write(to: imagePath)
       }

//       DispatchQueue.main.async { [weak self] in
//           guard let self = self else {return}
           switch textPosition {
           case .top:
               let tempMeme = Meme(imageName: meme.imageName, hasTopText: true, hasBottomText: meme.hasBottomText)
               self.delegate?.memeVCViewModel(self, didEditMeme: tempMeme)
           case .bottom:
               let tempMeme = Meme(imageName: meme.imageName, hasTopText: meme.hasTopText, hasBottomText: true)
               self.delegate?.memeVCViewModel(self, didEditMeme: tempMeme)
           }
//       }
   }
}
