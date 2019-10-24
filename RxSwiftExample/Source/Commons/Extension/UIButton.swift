//
//  UIButton.swift
//  KidsBook
//
//  Created by Dang Nguyen Vu on 9/5/18.
//  Copyright © 2018 XStudio. All rights reserved.
//

import UIKit

extension UIButton {
    func setup(title: String, font: UIFont, titleColor: UIColor, background: UIColor = UIColor.clear, controlState: UIControl.State = .normal) {
        let attrTitle = NSAttributedString(string: title,
                                           attributes: [NSAttributedString.Key.font: font,
                                                        NSAttributedString.Key.foregroundColor: titleColor])
        setBackgroundImage(UIImage.fromColor(background, size: bounds.size), for: controlState)
        setAttributedTitle(attrTitle, for: controlState)
    }

    func setup(title: String, font: UIFont, titleColor: UIColor, imageBackground: UIImage, controlState: UIControl.State = .normal) {
        setup(title: title, font: font, titleColor: titleColor, controlState: controlState)
        setBackgroundImage(imageBackground, for: controlState)
    }

    func setup(title: String, font: UIFont, titleColor: UIColor, backgroundColor: UIColor, controlState: UIControl.State = .normal) {
        titleLabel?.font = font
        setTitleColor(titleColor, for: controlState)
        setTitle(title, for: controlState)
        self.backgroundColor = backgroundColor
    }

    func setup(title: String, font: UIFont, titleColor: UIColor, imageBackgroundFromColor: UIColor, controlState: UIControl.State = .normal) {
        setup(title: title, font: font, titleColor: titleColor, controlState: controlState)
        setBackgroundImage(UIImage.fromColor(imageBackgroundFromColor, size: bounds.size), for: controlState)
    }

    func setup(image: UIImage, title: String, font: UIFont, tintColor: UIColor, imageBackgroundFromColor: UIColor, controlState: UIControl.State) {
        setImage(image.withRenderingMode(.alwaysOriginal), for: controlState)
        self.tintColor = tintColor
        setup(title: title, font: font, titleColor:
            tintColor, imageBackgroundFromColor: imageBackgroundFromColor, controlState: controlState)
    }

    func swapImage() {
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
}
