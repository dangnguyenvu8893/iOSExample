//
//  CGSize.swift
//  Ciphar
//
//  Created by Shohei Ohno on 2018/02/04.
//  Copyright © 2018年 Gungnir. All rights reserved.
//

import UIKit

extension CGSize {
    static func resize(max: CGFloat, width: CGFloat, height: CGFloat) -> CGSize {
        var rate: CGFloat = 0
        if width > height {
            rate = max / width
        } else {
            rate = max / height
        }
        return CGSize(width: width * rate, height: height * rate)
    }
}

func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
}
