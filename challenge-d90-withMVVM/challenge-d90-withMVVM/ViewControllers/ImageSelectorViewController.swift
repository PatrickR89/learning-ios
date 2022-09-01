//
//  ImageSelectorViewController.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

class ImageSelectorViewController: UIViewController {

    private var viewModel: ImageViewModel

    init(with viewModel: ImageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let picker = viewModel.createImagePickerController(in: self)
        present(picker, animated: true)
    }

    private func closeSelf() {
        self.dismiss(animated: true)
    }
}

extension ImageSelectorViewController: UIImagePickerControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            guard let image = info[.editedImage] as? UIImage else {return}
            viewModel.createNewImage(image: image)
            self.dismiss(animated: true)
            closeSelf()
        }
}

extension ImageSelectorViewController: UINavigationControllerDelegate {}
