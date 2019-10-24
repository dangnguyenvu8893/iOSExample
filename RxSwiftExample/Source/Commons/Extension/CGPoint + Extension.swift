//
//  CGPoint + Extension.swift
//  KidsBook
//
//  Created by Dang Nguyen Vu on 1/16/19.
//  Copyright © 2019 XStudio. All rights reserved.
//

import UIKit
import Foundation

extension CGPoint {
    
    func sub(point: CGPoint) -> CGPoint {
        return CGPoint(x: self.x - point.x, y: self.y - point.y)
    }
    
    func add(point: CGPoint) -> CGPoint {
        return CGPoint(x: self.x + point.x, y: self.y + point.y)
    }
}

extension CGAffineTransform {
    
    func getScale() -> CGFloat {
        return CGFloat(sqrt(Double(a * a + c * c)))
    }
}

