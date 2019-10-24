//
//  Array.swift
//
//  Copyright © 2016年 Gungnir. All rights reserved.
//

import Foundation

extension Array {

    func lastIndex() -> Int {
        return endIndex - 1
    }

    var second: Element? {
        return get(1)
    }

    var third: Element? {
        return get(2)
    }

    func get(_ index: Int) -> Element? {
        guard index < count else {
            return nil
        }
        return self[index]
    }
}

extension Array where Element: Equatable {

    mutating func removeObject(_ object: Element) {
        let indexObject = firstIndex(of: object)
        if let index = indexObject {
            remove(at: index)
        }
    }

    mutating func removeArray(_ objects: [Element]) {
        var array = self
        for object in objects {
            array.removeObject(object)
        }
        self = array
    }

    mutating func replace(_ object: Element) {
        if let index = firstIndex(of: object) {
            self[index] = object
        } else {
            append(object)
        }
    }

    mutating func replace(_ objects: [Element]) {
        var array = self
        for object in objects {
            array.replace(object)
        }
        self = array
    }
    
    func uniqueArray() -> [Element] {
        var array = [Element]()
        for object in self {
            if !array.contains(object) {
                array.append(object)
            }
        }
        return array
    }
}
