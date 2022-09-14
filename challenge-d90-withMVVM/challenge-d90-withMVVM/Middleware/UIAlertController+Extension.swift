//
//  UIAlertController+Extension.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 05.09.2022..
//

import UIKit

extension UIAlertController {

    func createEditAlertController(
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

            guard let meme = viewModel.delegate?.memeVCViewModelDidRequestMeme(viewModel),
                  let topTextEditable = viewModel.delegate?.memeVCViewModel(
                    viewModel,
                    didRequestStatusForTextAt: .top),
                  let bottomTextEditable = viewModel.delegate?.memeVCViewModel(
                    viewModel,
                    didRequestStatusForTextAt: .bottom) else {return nil}

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
                if !meme.hasTopText && topTextEditable {
                    return alertAction
                } else {
                    return nil
                }
            case .bottom:
                if !meme.hasBottomText && bottomTextEditable {
                    return alertAction
                } else {
                    return nil
                }
            }
        }

    func createShareAlertController(
        in viewController: UIViewController,
        with viewModel: MemeVCViewModel) -> UIAlertController {
        let alertController = UIAlertController(
            title: "Enter name",
            message: "Name your meme before you send it",
            preferredStyle: .alert)

        alertController.addTextField()

        let titleAction = UIAlertAction(title: "Send", style: .default) { [weak alertController, weak viewModel] _ in
            print("init")
            guard let viewModel = viewModel,
                  let title = alertController?.textFields?[0].text else {return}
            let imageName = viewModel.imageNameRequested()
            print(imageName)
            let path = FileManager.default.getFilePath(imageName)
            print(path)
            do {
                let data = try Data(contentsOf: path)
                guard let image = UIImage(data: data) else {return}
                print("lets")
                let activityController = UIActivityViewController(
                    activityItems: [image, title],
                    applicationActivities: [])
                viewController.present(activityController, animated: true)
            } catch {
                print(error)
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(titleAction)
        alertController.addAction(cancelAction)

        return alertController
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
                    print(path)
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
