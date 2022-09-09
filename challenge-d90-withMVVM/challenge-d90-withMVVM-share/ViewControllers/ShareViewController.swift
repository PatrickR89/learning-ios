//
//  ShareViewController.swift
//  ShareMemeImages
//
//  Created by Patrick on 06.09.2022..
//

import UIKit
import MobileCoreServices
import RealmSwift
import UniformTypeIdentifiers

@objc (ShareExtensionViewController)

class ShareViewController: UIViewController {
    var realm: Realm?
    let viewModel = ShareViewModel()
    var shareView: ShareView?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupUI()
        viewModel.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add image to MemeEditor"
        handleInput()
    }

    private func handleInput() {
        let attachments = (self.extensionContext?.inputItems.first as? NSExtensionItem)?.attachments ?? []
        let contentType = kUTTypeData as String
        viewModel.handleData(in: attachments, with: contentType)
    }

    private func setupUI() {
        let shareView = ShareView(with: viewModel)
        shareView.frame = view.frame
        shareView.setBackground()
        self.view = shareView
    }
}

extension ShareViewController: ShareViewModelDelegate {
    func shareViewModel(_ viewModel: ShareViewModel, didCompleteRequestWith array: [Any]?) {
        self.extensionContext?.completeRequest(returningItems: array)
    }

    func shareViewModel(_ viewModel: ShareViewModel, didCancelRequestWithError error: Error?) {
        self.extensionContext?.cancelRequest(withError: error!)
    }
}
