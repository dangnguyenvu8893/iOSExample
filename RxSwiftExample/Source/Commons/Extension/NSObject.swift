//
//  NSObject.swift
//  airCloset
//
//  Created by Shohei Ohno on 2016/01/14.
//  Copyright © 2016年 Gungnir. All rights reserved.
//

import Foundation

extension NSObject {
    class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    var className: String {
        return String(describing: type(of: self))
    }
}
