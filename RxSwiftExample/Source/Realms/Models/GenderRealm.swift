//
//  GenderRealm.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/21/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import RealmSwift

class GenderRealm: Object {
    
    @objc dynamic var value = 2
    
    static func create(_ gender: Person.Gender?) -> GenderRealm {
        let obj = GenderRealm()
        obj.value = gender?.rawValue ?? Person.Gender.unknow.rawValue
        return obj
    }
    
    var gender: Person.Gender {
        return Person.Gender(rawValue: value) ?? .unknow
    }
    
    override class func primaryKey() -> String? {
        return "value"
    }
}
