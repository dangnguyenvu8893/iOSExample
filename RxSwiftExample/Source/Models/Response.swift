//
//  Meta.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/20/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import ObjectMapper

struct Response<T: Mappable> {
    
    var page: Int?
    var results: [T] = []
    var totalResults: Int?
    var totalPages: Int?
}

extension Response: Mappable {

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        page <- map["page"]
        results <- map["results"]
        totalPages <- map["total_pages"]
        totalResults <- map["total_results"]
    }
}
