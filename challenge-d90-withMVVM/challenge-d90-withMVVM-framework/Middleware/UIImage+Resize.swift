//
//  UIImage+Extension.swift
//  challenge-d90-withMVVM-framework
//
//  Created by Patrick on 09.09.2022..
//

import UIKit

extension UIImage {
    func resizeImage() -> UIImage {
        let oldWidth = self.size.width
        let oldHeight = self.size.height

        if oldWidth > 1024 {
            let newHeight = 1024 * (oldHeight / oldWidth)
            let renderRect = CGRect(origin: .zero, size: CGSize(width: 1024, height: newHeight))
            return renderResizedImage(in: renderRect)
        } else if oldHeight > 1024 {
            let newWidth = 1024 * ( oldWidth / oldHeight)
            let renderRect = CGRect(origin: .zero, size: CGSize(width: newWidth, height: 1024))
            return renderResizedImage(in: renderRect)
        } else {
            return self
        }
    }

    private func renderResizedImage(in renderRect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: renderRect.size)

        let newImage = renderer.image { _ in
            self.draw(in: renderRect)
        }

        return newImage
    }
}
