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

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.realm = RealmDataService.shared.initiateRealm()
        }

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
                        saveData(imageData)
                    } else {
                        self.extensionContext?.cancelRequest(withError: error!)
                    }
                }
            }
        }
    }

    private func saveData(_ imageData: Data) {
        guard let image = UIImage(data: imageData) else {fatalError("Unable to load image")}
        let newImageName = UUID().uuidString
        let newImagePath = FileManager.default.getFilePath(newImageName)
        if let jpegData = image.jpegData(compressionQuality: 0.5),
           let realm = self.realm {
            try? jpegData.write(to: newImagePath)
            let meme = Meme(imageName: newImageName, hasTopText: false, hasBottomText: false)
            DispatchQueue.main.async {
                try? realm.write {
                    realm.add(meme)
                    print(meme)
                    self.extensionContext?.completeRequest(returningItems: nil)
                }
            }
        }
    }
}
