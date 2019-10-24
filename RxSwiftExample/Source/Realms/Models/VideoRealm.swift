//
//  VideoRealm.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/21/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import RealmSwift

class VideoRealm: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String? = nil
    @objc dynamic var site: String? = nil
    @objc dynamic var size: Int = 0
    @objc dynamic var type: String? = nil
    
    static func create(with video: Video) -> VideoRealm {
        let obj = VideoRealm()
        obj.id = video.id ?? 0
        obj.name = video.name
        obj.site = video.site
        obj.size = video.size?.rawValue ?? 360
        obj.type = video.type?.rawValue
        return obj
    }
    
    var video: Video {
        return Video(id: id, name: name, site: site, size: Video.Size(rawValue: size), type: Video.VideoType(rawValue: type ?? ""))
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
