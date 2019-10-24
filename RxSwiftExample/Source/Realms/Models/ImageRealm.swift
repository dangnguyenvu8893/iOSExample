//
//  ImageRealm.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/21/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import RealmSwift

class ImageRealm: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var ratio: Double = 1.0
    @objc dynamic var path: String? = nil
    
    static func create(with image: Image) -> ImageRealm {
        let obj = ImageRealm()
        obj.id = image.id ?? 0
        obj.ratio = image.ratio ?? 1.0
        obj.path = image.path
        return obj
    }
    
    var image: Image {
        return Image(id: id, ratio: ratio, path: path)
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
