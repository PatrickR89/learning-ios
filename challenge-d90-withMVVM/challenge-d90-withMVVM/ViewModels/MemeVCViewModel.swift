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
    // MARK: create alert controller
    func createAlertController(in viewController: UIViewController) -> UIAlertController {
        let alertController = UIAlertController(
            title: "Edit or delete image",
            message: nil, preferredStyle: .actionSheet)
        let addTextToTop = createAlertAction(position: .top, to: alertController, in: viewController )
        let addBottomText = createAlertAction(position: .bottom, to: alertController, in: viewController )

        let deleteImage = UIAlertAction(
            title: "DELETE MEME",
            style: .destructive) { [weak viewController, weak self] _ in
                guard let self = self,
                      let meme = self.delegate?.memeVCViewModelDidRequestMeme(self) else {return}
                let imageName = meme.image
                let path = FileManager.default.getFilePath(imageName)
                do {
                    try FileManager.default.removeItem(at: path)
                } catch {
                    print("Error in deleting")
                }
                self.delegate?.memeVCViewModel(self, didDeleteMeme: meme)
                viewController?.dismiss(animated: true)
            }

        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel)

        if let addTextToTop = addTextToTop {
            alertController.addAction(addTextToTop)
        }

        if let addBottomText = addBottomText {
            alertController.addAction(addBottomText)
        }

        alertController.addAction(deleteImage)
        alertController.addAction(cancelAction)

        return alertController
    }
}

private extension MemeVCViewModel {

    // MARK: create alert action

    func createAlertAction(
        position: Position,
        to alertController: UIAlertController,
        in viewController: UIViewController) -> UIAlertAction? {

            var title: String
            guard let meme = self.delegate?.memeVCViewModelDidRequestMeme(self) else {return nil}
            switch position {
            case .top:
                title = "Add text on top"
            case .bottom:
                title = "Add text on bottom"
            }

            let alertAction = UIAlertAction(
                title: title,
                style: .default) { [weak alertController, weak viewController] _ in
                    let textAlertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
                    textAlertController.addTextField()
                    let addText = UIAlertAction(
                        title: "ADD",
                        style: .default) { [weak textAlertController, weak self] _ in
                            guard let self = self,
                                  let textAlertController = textAlertController,
                                  let meme = self.delegate?.memeVCViewModelDidRequestMeme(self),
                                  let text = textAlertController.textFields?[0].text else {return}
                            DispatchQueue.global(qos: .userInitiated).async {
                                self.editImage(meme: meme, text: text, at: position)
                            }
                        }

                    let cancel = UIAlertAction(title: "Cancel", style: .cancel)
                    textAlertController.addAction(addText)
                    textAlertController.addAction(cancel)
                    alertController?.dismiss(animated: true)
                    viewController?.present(textAlertController, animated: true)
                }

            switch position {
            case .top:
                if !meme.hasTopText {
                    return alertAction
                } else {
                    return nil
                }
            case .bottom:
                if !meme.hasBottomText {
                    return alertAction
                } else {
                    return nil
                }
            }
        }

    // MARK: edit image

    private func editImage(meme: Meme, text: String, at textPosition: Position) {
        let imagePath = FileManager.default.getFilePath(meme.image)
        guard let image = UIImage(contentsOfFile: imagePath.path) else {return}

        let imageWithText = image.addMemeText(text: text, at: textPosition)
        if let jpegData = imageWithText.jpegData(compressionQuality: 0.5) {
            try? jpegData.write(to: imagePath)
        }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            switch textPosition {
            case .top:
                let tempMeme = Meme(image: meme.image, hasTopText: true, hasBottomText: meme.hasBottomText)
                self.delegate?.memeVCViewModel(self, didEditMeme: tempMeme)
            case .bottom:
                let tempMeme = Meme(image: meme.image, hasTopText: meme.hasTopText, hasBottomText: true)
                self.delegate?.memeVCViewModel(self, didEditMeme: tempMeme)
            }
        }
    }
}
