//
//  UIAlertController+Extension.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 05.09.2022..
//

import UIKit

extension UIAlertController {

    func createAlertController(
        in viewController: UIViewController,
        with viewModel: MemeVCViewModel) -> UIAlertController {
            let alertController = UIAlertController(
                title: "Edit meme",
                message: nil, preferredStyle: .actionSheet)
            let editTopText = createAlertAction(
                position: .top, to: alertController,
                in: viewController, with: viewModel )
            let editBottomText = createAlertAction(
                position: .bottom, to: alertController,
                in: viewController, with: viewModel )

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

            if let editTextToTop = editTopText { alertController.addAction(editTextToTop) }
            if let editBottomText = editBottomText { alertController.addAction(editBottomText) }

            alertController.addAction(cancelAction)

            return alertController
        }

    private func createAlertAction(
        position: Position,
        to alertController: UIAlertController,
        in viewController: UIViewController,
        with viewModel: MemeVCViewModel) -> UIAlertAction? {

            var title: String
            guard let meme = viewModel.delegate?.memeVCViewModelDidRequestMeme(viewModel) else {return nil}
            switch position {
            case .top:
                title = "Edit text on top"
            case .bottom:
                title = "Edit text on bottom"
            }

            let alertAction = UIAlertAction(
                title: title,
                style: .default) { [weak alertController, weak viewController] _ in
                    let textAlertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
                    textAlertController.addTextField()
                    let addText = UIAlertAction(
                        title: "Edit",
                        style: .default) { [weak textAlertController, weak viewModel] _ in
                            guard let viewModel = viewModel,
                                  let textAlertController = textAlertController,
                                  let text = textAlertController.textFields?[0].text else {return}

                            viewModel.editImage(text: text, at: position)

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

    func createDeletionAlertController(
        in viewController: UIViewController,
        with viewModel: MemeVCViewModel) -> UIAlertController {

            let deleteAlertController = UIAlertController(
                title: "Delete",
                message: "Do you want to delete this meme?",
                preferredStyle: .alert)

            let deleteImage = UIAlertAction(
                title: "Yes",
                style: .default) { [weak viewController, weak viewModel] _ in
                    guard let viewModel = viewModel,
                          let meme = viewModel.delegate?.memeVCViewModelDidRequestMeme(viewModel) else {return}
                    let imageName = meme.imageName
                    let path = FileManager.default.getFilePath(imageName)
                    do {
                        try FileManager.default.removeItem(at: path)
                    } catch {
                        print("Error in deleting")
                    }
                    viewModel.delegate?.memeVCViewModel(viewModel, didDeleteMeme: meme)
                    viewController?.dismiss(animated: true)
                }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

            deleteAlertController.addAction(cancelAction)
            deleteAlertController.addAction(deleteImage)
            return deleteAlertController
        }
}
