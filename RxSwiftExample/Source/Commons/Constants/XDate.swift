//
//  Date.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/19/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation

struct XDate {
    
    static var shared = XDate()
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD"
        formatter.timeZone = TimeZone(identifier: "US")
        return formatter
    }()
}
