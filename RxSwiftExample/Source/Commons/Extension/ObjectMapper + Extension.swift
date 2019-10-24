//
//  ObjectMapper + Extension.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/19/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import ObjectMapper

open class DateStringFormatTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    public let format: String
    
    public init(format: String) {
        self.format = format
    }
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        if let dateString = value as? String {
            return dateFormatter.date(from: dateString)
        }
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
