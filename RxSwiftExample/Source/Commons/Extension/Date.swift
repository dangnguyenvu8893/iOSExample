//
//  Date.swift
//  KidsBook
//
//  Created by Dang Nguyen Vu on 9/5/18.
//  Copyright © 2018 XStudio. All rights reserved.
//

import Foundation

struct DateTime {
    static var shared = DateTime()

    var dateFormatter = DateFormatter()

    lazy var today: Date = {
        let date = Date()
        return Date.fromString(text: "\(date.day)/\(date.month)/\(date.year) - 00:00:00", format: "dd/MM/yyyy - HH:mm:ss") ?? date
    }()
}

extension Date {

    static var today: Date {
        return DateTime.shared.today
    }

    static func fromString(text: String, format: String) -> Date? {
        DateTime.shared.dateFormatter.dateFormat = format
        return DateTime.shared.dateFormatter.date(from: text)
    }

    func toString(format: String) -> String? {
        DateTime.shared.dateFormatter.dateFormat = format
        return DateTime.shared.dateFormatter.string(from: self)
    }

    static func dateFromFirebaseTimestamp(_ value: Double) -> Date {
        return Date(timeIntervalSince1970: value / 1000)
    }

    var firebaseTimestamp: TimeInterval {
        return self.timeIntervalSince1970 * 1000
    }

    var year: Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: self)
    }

    var month: Int {
        let calendar = Calendar.current
        return calendar.component(.month, from: self)
    }

    var day: Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: self)
    }

    var hour: Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: self)
    }

    var minute: Int {
        let calendar = Calendar.current
        return calendar.component(.minute, from: self)
    }

    var second: Int {
        let calendar = Calendar.current
        return calendar.component(.second, from: self)
    }

    func isSameDay(with date: Date) -> Bool {
        return year == date.year && month == date.month && day == date.day
    }

    func isToday() -> Bool {
        return isSameDay(with: Date())
    }

    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }

    var dateOnly: Date {
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }
}

extension Date {

    func dayTimeStamp() -> Int? {
        let fromDate = Date(timeIntervalSince1970: 0)
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let components = calendar.dateComponents([.day], from: fromDate, to: self)
        return components.day
    }

    static func date(from dayTimeStamp: Int) -> Date? {
        let fromDate = Date(timeIntervalSince1970: 0)
        var component = DateComponents()
        component.timeZone = TimeZone(secondsFromGMT: 0)!
        component.day = dayTimeStamp + 1
        component.hour = 0

        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let nextDate = calendar.date(byAdding: component, to: fromDate)
        return nextDate
    }

    func monthBetween(_ date: Date?) -> Int {
        guard let date = date, date < self else {
            return 0
        }
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let components = calendar.dateComponents([.month], from: date, to: self)
        return components.month ?? 0
    }

    static func monthBetweenNow(_ date: Date?) -> Int {
        return Date().monthBetween(date)
    }
}
