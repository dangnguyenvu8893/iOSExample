//
//  Image.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/20/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import ObjectMapper

struct Image {
    
    var id: Int?
    var ratio: Double?
    var path: String?
    
    func getImageString<T: RawRepresentable>(size: T) -> String? where T.RawValue == String {
        return ImageManager.getImageString(size: size, path: path)
    }
}

extension Image: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        ratio <- map["aspect_ratio"]
        path <- map["file_path"]
    }
}
