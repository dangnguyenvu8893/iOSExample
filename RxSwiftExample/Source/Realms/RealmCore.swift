//
//  RealmCore.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/22/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCore {
    static let shared = RealmCore()
    var realm = try! Realm()
}
