//
//  MemeViewController.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

class MemeViewController: UIViewController {

    private var memeView: MemeView
    private var viewModel: MemeVCViewModel

    init(memeViewModel: MemeViewModel, with viewModel: MemeVCViewModel) {
        self.viewModel = viewModel
        self.memeView = MemeView(with: memeViewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationController?.isToolbarHidden = false

        bindNavigationItem()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .plain,
            target: self,
            action: #selector(closeSelf))
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        memeView.viewModel.saveChanges()
        memeView.viewModel.resetImageLayer()
    }
}

private extension MemeViewController {
    @objc func closeSelf() {
        self.dismiss(animated: true)
    }

    func setupUI() {
        view.addSubview(memeView)
        memeView.frame = view.bounds
        memeView.setBackground()
        memeView.delegate = self
    }

    func bindNavigationItem() {
        viewModel.observeImageState { imageState in
            DispatchQueue.main.async { [weak self] in
                self?.toggleToolbar(imageState)
            }
        }

        viewModel.observeEditState { editState in
            DispatchQueue.main.async { [weak self] in
                self?.appendEditButton(isEditingEnabled: editState)
            }

        }
    }

    func toggleToolbar(_ imageState: Bool) {
        addToolbarItems(loadedImage: imageState)
    }

    func addToolbarItems(loadedImage state: Bool) {

        let deleteIcon = UIImage(systemName: "trash")

        let deleteButton = UIBarButtonItem(
            image: deleteIcon,
            style: .plain,
            target: self,
            action: #selector(deleteMeme))
        deleteButton.tintColor = .systemRed

        let shareIcon = UIImage(systemName: "square.and.arrow.up")
        let shareButton = UIBarButtonItem(
            image: shareIcon,
            style: .plain,
            target: self,
            action: #selector(shareMeme))

        let spacer = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)

        if state == false {
            toolbarItems?.append(deleteButton)
            toolbarItems?.append(spacer)
        } else if state == true {
            toolbarItems = []
            toolbarItems?.append(deleteButton)
            toolbarItems?.append(spacer)
            toolbarItems?.append(spacer)
            toolbarItems?.append(spacer)
            toolbarItems?.append(shareButton)
        }
    }

    func appendEditButton(isEditingEnabled editing: Bool) {

        let editIcon = UIImage(systemName: "pencil")
        let editButton = UIBarButtonItem(
            image: editIcon,
            style: .plain,
            target: self,
            action: #selector(openActionController))

        let spacer = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)

        if editing == true {
            toolbarItems?[2] = editButton
        } else {
            toolbarItems?[2] = spacer
        }
    }

    @objc func openActionController() {
        let alertController = viewModel.addAlertController(in: self)
        present(alertController, animated: true)
    }

    @objc func deleteMeme() {
        let alertController = viewModel.addDeletionAlertController(in: self)
        present(alertController, animated: true)
    }

    @objc func shareMeme() {
        let alertController = viewModel.shareMeme(in: self)
        present(alertController, animated: true)
    }
}

extension MemeViewController: MemeViewDelegate {

    func memeViewDidTapImage(_ view: MemeView) {
        let picker = viewModel.createImagePickerController(in: self)
        present(picker, animated: true)
    }
}

extension MemeViewController: UIImagePickerControllerDelegate {

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            guard let image = info[.editedImage] as? UIImage else {return}
            viewModel.createNewImage(image: image)
            self.dismiss(animated: true)
        }
}

extension MemeViewController: UINavigationControllerDelegate {}
