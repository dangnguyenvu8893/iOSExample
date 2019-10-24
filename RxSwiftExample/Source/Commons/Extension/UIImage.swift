//
//  UIImage.swift
//
//  Created by Dang Nguyen Vu on 12/13/17.
//  Copyright © 2017 XProduction. All rights reserved.
//

import UIKit

extension UIImage {
    static func fromColor(_ color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let nilableContext = UIGraphicsGetCurrentContext()
        guard let context = nilableContext else {
            return UIImage()
        }
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
}
