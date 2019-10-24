//
//  UITextField.swift
//
//  Created by Dang Nguyen Vu on 12/13/17.
//  Copyright © 2017 XProduction. All rights reserved.
//

import UIKit

extension UITextField {

    func setup(font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment = .left) {
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
    }

    func setColorPlaceholder(text: String, color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(string: text,
                                                        attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}
