//
//  UITextView.swift
//
//  Created by Dang Nguyen Vu on 12/14/17.
//  Copyright © 2017 XProduction. All rights reserved.
//

import UIKit

extension UITextView {
    func setup(font: UIFont, textColor: UIColor, backgroundColor: UIColor = UIColor.clear, text: String? = nil) {
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.text = text
    }

    func setup(font: UIFont, textColor: UIColor, aligment: NSTextAlignment, backgroundColor: UIColor = UIColor.clear, text: String? = nil) {
        self.setup(font: font, textColor: textColor, backgroundColor: backgroundColor, text: text)
        self.textAlignment = aligment
    }

    func setLineSpacing(lineHeight: CGFloat = 0.0,
                        alignment: NSTextAlignment = .left,
                        lineSpace: CGFloat = 0.0,
                        lineBreakMode: NSLineBreakMode = .byWordWrapping) {
        guard let labelText = self.text else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        let lineHeightMultiple = lineHeight / (self.font?.lineHeight ?? 1)

        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.lineBreakMode = lineBreakMode
        paragraphStyle.alignment = alignment

        let attributedString: NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:
                paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
}
