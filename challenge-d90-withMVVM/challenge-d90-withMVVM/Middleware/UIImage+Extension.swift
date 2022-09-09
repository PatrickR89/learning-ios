//
//  UIImage+Extension.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 05.09.2022..
//

import UIKit

extension UIImage {
    func addMemeText( text: String, at textPosition: Position) -> UIImage {

        let image = self.resizeImage()
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        format.preferredRange = .standard

        let renderer = UIGraphicsImageRenderer(
            size: CGSize(
                width: image.size.width,
                height: image.size.height),
            format: format)
        let newImage = renderer.image { _ in
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
            let attributedString = NSAttributedString(string: text, attributes: paragraphAttributes)

            image.draw(at: CGPoint(x: 0, y: 0))

            let textFrame = createTextFrame(size: image.size, position: textPosition)
            attributedString.draw(with: textFrame, options: .usesLineFragmentOrigin, context: nil)
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
}
