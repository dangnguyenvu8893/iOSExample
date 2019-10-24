//
//  PersonRealm.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/21/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import RealmSwift

class PersonRealm: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String? = nil
    @objc dynamic var birthday: Date? = nil
    @objc dynamic var deathday: Date? = nil
    @objc dynamic var gender: GenderRealm? = nil
    @objc dynamic var biography: String? = nil
    @objc dynamic var homepage: String? = nil
    @objc dynamic var profilePath: String? = nil
    @objc dynamic var job: String? = nil
    @objc dynamic var charater: String? = nil
    
    static func create(with person: Person) -> PersonRealm {
        let genderRealm = GenderRealm.create(person.gender)
        let obj = PersonRealm()
        obj.id = person.id ?? 0
        obj.birthday = person.birthday
        obj.deathday = person.deathday
        obj.name = person.name
        obj.gender = genderRealm
        obj.biography = person.biography
        obj.homepage = person.homepage
        obj.profilePath = person.profilePath
        obj.charater = person.character
        obj.job = person.job
        return obj
    }
    
    var person: Person {
        return Person(id: id,
                      name: name,
                      birthday: birthday,
                      deathday: deathday,
                      gender: Person.Gender(rawValue: gender?.value ?? Person.Gender.unknow.rawValue),
                      biography: biography,
                      homepage: homepage,
                      profilePath: profilePath,
                      job: job,
                      character: charater)
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
