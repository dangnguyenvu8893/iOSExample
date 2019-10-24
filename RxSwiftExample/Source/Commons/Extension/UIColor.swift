//
//  UIColor.swift
//  Ciphar
//
//  Created by Shohei Ohno on 2017/09/11.
//  Copyright © 2017年 Gungnir. All rights reserved.
//

import UIKit

extension UIColor {

    static func rgba(_ red: Int?, green: Int?, blue: Int?, alpha: CGFloat = 1.0) -> UIColor {

        guard let r = red, let g = green, let b = blue else {
            return .white
        }

        let denominator: CGFloat = 255.0
        let color = UIColor(red: CGFloat(r) / denominator, green: CGFloat(g) / denominator, blue: CGFloat(b) / denominator, alpha: alpha)
        return color
    }

    static func hex(_ hexStr: String, alpha: CGFloat = 1) -> UIColor {
        let scanner = Scanner(string: hexStr.replacingOccurrences(of: "#", with: ""))
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
        } else {
            return .white
        }
    }
}
