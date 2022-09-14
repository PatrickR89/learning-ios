//
//  UIImage+Extension.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 05.09.2022..
//

import UIKit

extension UIImage {

    func addMemeText( topText: String, bottomText: String ) -> UIImage {
        let image = self.resizeImage()
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        format.preferredRange = .standard

        let renderer = UIGraphicsImageRenderer(
            size: CGSize(
                width: image.size.width,
                height: image.size.height),
            format: format)
        let tempImage = renderer.image { _ in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            guard let customFont = UIFont(name: "Lato-Regular", size: 50) else {
                fatalError( "Font not found" )
            }

            let paragraphAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFontMetrics.default.scaledFont(for: customFont),
                .foregroundColor: UIColor.white,
                .backgroundColor: UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3),
                .paragraphStyle: paragraphStyle
            ]

            if topText != "" {
                let attributedString = NSAttributedString(string: topText, attributes: paragraphAttributes)

                let textFrame = createTopTextFrame(size: image.size)
                attributedString.draw(with: textFrame, options: .usesLineFragmentOrigin, context: nil)
            }

            if bottomText != "" {
                let attributedString = NSAttributedString(string: bottomText, attributes: paragraphAttributes)

                let textFrame = createBottomTextFrame(size: image.size)
                attributedString.draw(with: textFrame, options: .usesLineFragmentOrigin, context: nil)
            }
        }
        return tempImage
    }

    func saveImage(with imageLayer: UIImage) -> UIImage {
        let image = self

        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        format.preferredRange = .standard

        let renderer = UIGraphicsImageRenderer(
            size: CGSize(
                width: image.size.width,
                height: image.size.height),
            format: format)
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)

        let newImage = renderer.image { _ in
            image.draw(at: CGPoint(x: 0, y: 0))
            imageLayer.draw(in: rect)
        }

        return newImage
    }

    // MARK: create textFrame for editImage

    private func createTextFrame(size: CGSize, position: Position) -> CGRect {
        let width = size.width * 0.9
        let height = size.height * 0.2
        let xPos = size.width * 0.05
        var yPos: CGFloat = 0
        switch position {
        case .top:
            yPos = size.height * 0.1
        case .bottom:
            yPos = size.height - height
        }

        return CGRect(x: xPos, y: yPos, width: width, height: height)
    }

    private func createTopTextFrame(size: CGSize) -> CGRect {
        let width = size.width * 0.9
        let height = size.height * 0.2
        let xPos = size.width * 0.05
        let yPos = size.height * 0.1

        return CGRect(x: xPos, y: yPos, width: width, height: height)
    }

    private func createBottomTextFrame(size: CGSize) -> CGRect {
        let width = size.width * 0.9
        let height = size.height * 0.2
        let xPos = size.width * 0.05
        let yPos = size.height - height

        return CGRect(x: xPos, y: yPos, width: width, height: height)
    }
}
