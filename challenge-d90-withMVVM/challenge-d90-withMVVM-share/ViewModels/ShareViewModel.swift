//
//  ShareViewModel.swift
//  challenge-d90-withMVVM-share
//
//  Created by Patrick on 09.09.2022..
//

import UIKit
import RealmSwift

class ShareViewModel {
    private var realm: Realm?
    weak var delegate: ShareViewModelDelegate?
    private var image: UIImage? {
        didSet {
            valueDidChange()
        }
    }

    init() {
        setupRealm()
    }

    private var observer: ((UIImage) -> Void)?

    private func valueDidChange() {
        guard let observer = observer,
              let image = image else {
            return
        }
        observer(image)
    }

    private func setupRealm() {
        DispatchQueue.main.async {
            self.realm = RealmDataService.shared.initiateRealm()
        }
    }

    func observeImage(_ closure: @escaping (UIImage) -> Void) {
        self.observer = closure
        valueDidChange()
    }
}

extension ShareViewModel {
    func handleData(in attachments: [NSItemProvider], with contentType: String) {
        for provider in attachments {
            if provider.hasItemConformingToTypeIdentifier(contentType) {
                provider.loadItem(forTypeIdentifier: contentType) { [unowned self] (data, error) in
                    guard error == nil else {return}
                    if let url = data as? URL,
                       let imageData = try? Data(contentsOf: url) {
                        loadImage(fromData: imageData)
                    } else {
                        delegate?.shareViewModel(self, didCancelRequestWithError: error)
                    }
                }
            }
        }
    }

    private func loadImage(fromData imageData: Data) {
        guard let image = UIImage(data: imageData) else {fatalError("Unable to load image")}
        self.image = image
    }

    func saveImage() {
        guard let image = image else {return}
        let newImageName = UUID().uuidString
        let newImagePath = FileManager.default.getFilePath(newImageName)
        if let jpegData = image.jpegData(compressionQuality: 0.5),
           let realm = self.realm {
            try? jpegData.write(to: newImagePath)
            let meme = Meme(imageName: newImageName, hasTopText: false, hasBottomText: false, dateAdded: Date.now)
            DispatchQueue.main.async { [weak self] in
                try? realm.write {
                    realm.add(meme)
                    guard let self = self else {return}
                    self.delegate?.shareViewModel(self, didCompleteRequestWith: nil)
                }
            }
        }
    }

    func cancelRequest() {
        self.delegate?.shareViewModel(self, didCompleteRequestWith: nil)
    }
}
