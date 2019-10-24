//
//  XFont.swift
//  Translator
//
//  Created by XStudio on 3/2/19.
//  Copyright © 2019 XStudio. All rights reserved.
//

import Foundation
import UIKit

struct XFont {
    
    static func regular(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    static func bold(_ size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
    
    static func italic(_ size: CGFloat) -> UIFont {
        return UIFont.italicSystemFont(ofSize: size)
    }
}
