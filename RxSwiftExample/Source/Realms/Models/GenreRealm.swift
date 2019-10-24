//
//  GenreRealm.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/21/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import RealmSwift

class GenreRealm: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String? = nil
    
    static func create(with genre: Genre) -> GenreRealm {
        let object = GenreRealm()
        object.id = genre.id ?? 0
        object.name = genre.name
        return object
    }

    var genre: Genre {
        return Genre(id: id, name: name)
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
