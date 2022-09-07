//
//  ShareViewController.swift
//  ShareMemeImages
//
//  Created by Patrick on 06.09.2022..
//

import UIKit
import MobileCoreServices
import RealmSwift

@objc (ShareExtensionViewController)

class ShareViewController: UIViewController {
    let realm: Realm

    init () {
        self.realm = RealmDataService.shared.initiateRealm()
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        handleShared()
    }

    private func handleShared() {
        let attachments = (self.extensionContext?.inputItems.first as? NSExtensionItem)?.attachments ?? []
        let contentType = kUTTypeData as String
        for provider in attachments {
            if provider.hasItemConformingToTypeIdentifier(contentType) {
                provider.loadItem(forTypeIdentifier: contentType) { [unowned self] (data, error) in
                    guard error == nil else {return}
                    if let url = data as? URL,
                       let imageData = try? Data(contentsOf: url) {

                    } else {
                        fatalError("Unable to save!")
                    }
                }
            }
        }
    }
}
