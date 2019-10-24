//
//  Video.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/20/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import ObjectMapper

struct Video {
    
    var id: Int?
    var name: String?
    var site: String?
    var size: Size?
    var type: VideoType?
}

extension Video {
    
//    Allowed Values: Trailer, Teaser, Clip, Featurette, Behind the Scenes, Bloopers
    enum VideoType: String, CaseIterable {
        case trailer = "Trailer"
        case teaser = "Teaser"
        case clip = "Clip"
        case featurette = "Featurette"
        case behindTheScenes = "Behind the Scenes"
        case Bloopers = "Bloopers"
        
        static var transform: TransformOf<VideoType, String> {
            return TransformOf<VideoType, String>(fromJSON: { str -> Video.VideoType? in
                return VideoType(rawValue: str ?? "")
            }, toJSON: { type -> String? in
                return type?.rawValue
            })
        }
    }
    
    enum Size: Int, CaseIterable {
        case s360 = 360
        case s480 = 480
        case s720 = 720
        case s1080 = 1080
        
        static var transform: TransformOf<Size, Int> {
            return TransformOf<Size, Int>(fromJSON: { number -> Video.Size? in
                guard let number = number else { return nil }
                return Size(rawValue: number)
            }, toJSON: { size -> Int? in
                return size?.rawValue
            })
        }
    }
}

extension Video: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        site <- map["site"]
        size <- (map["size"], Size.transform)
        type <- (map["type"], VideoType.transform)
    }
}
