//
//  People.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/19/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import ObjectMapper

struct Person {
    
    var id: Int?
    var name: String?
    var birthday: Date?
    var deathday: Date?
    var gender: Gender?
    var biography: String?
    var homepage: String?
    var profilePath: String?
    var job: String?
    var character: String?
}

extension Person {
    
    enum Gender: Int, CaseIterable {
        case female
        case male
        case unknow
        
        static var transform: TransformOf<Gender, Int> {
            return TransformOf<Gender, Int>(fromJSON: { id -> Person.Gender? in
                return Gender(rawValue: id ?? 2)
            }, toJSON: { gender -> Int? in
                return gender?.rawValue
            })
        }
    }
}

extension Person: Mappable {

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        birthday <- (map["birthday"], DateFormatterTransform(dateFormatter: XDate.shared.formatter))
        deathday <-  (map["deathday"], DateFormatterTransform(dateFormatter: XDate.shared.formatter))
        gender <- (map["gender"], Gender.transform)
        biography <- map["biography"]
        homepage <- map["homepage"]
        profilePath <- map["profile_path"]
        job <- map["job"]
        character <- map["character"]
    }
}
