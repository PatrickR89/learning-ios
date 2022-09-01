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
    private var imageViewModel = ImageViewModel()

    init(memeViewModel: MemeViewModel, with viewModel: MemeVCViewModel) {
        self.viewModel = viewModel
        self.memeView = MemeView(with: memeViewModel, imageViewModel: imageViewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindNavigationItem()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "CLOSE",
            style: .plain,
            target: self,
            action: #selector(closeSelf))
    }
}

private extension MemeViewController {
    @objc func closeSelf() {
        self.dismiss(animated: true)
    }

    func setupUI() {
        view.addSubview(memeView)
        memeView.frame = view.bounds
        memeView.delegate = self
    }

    func bindNavigationItem() {
        viewModel.observeImageState { imageState in
            DispatchQueue.main.async { [weak self] in
                self?.toggleBarButton(imageState)
            }
        }
    }

    func toggleBarButton(_ imageState: Bool) {
        if imageState {
            let editBarButton = UIBarButtonItem(
                title: "EDIT",
                style: .plain,
                target: self,
                action: #selector(openActionController))
            self.navigationItem.leftBarButtonItem = editBarButton
        }
    }

    @objc func openActionController() {
        let alertController = viewModel.createAlertController(in: self)
        present(alertController, animated: true)
    }
}

extension MemeViewController: MemeViewDelegate {
    func memeViewDidTapImage(_ view: MemeView) {
        let viewController = ImageSelectorViewController(with: imageViewModel)
        present(viewController, animated: true)
    }
}
