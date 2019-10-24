//
//  ImageManager.swift
//  RxSwiftExampleTests
//
//  Created by Vu Dang on 10/23/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import UIKit

class ImageManager {
    
    class func image(named: String?) -> UIImage? {
        guard let named = named else { return nil }
        return UIImage(named: named, in: Bundle(for: ImageManager.self), compatibleWith: nil)!
    }
}
