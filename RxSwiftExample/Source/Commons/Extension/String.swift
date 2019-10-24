//
//  String.swift
//  airCloset
//
//  Created by Shohei Ohno on 2015/11/09.
//  Copyright © 2015年 Gungnir. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var isEmail: Bool {
        get {
            let regexString = "^(([a-zA-Z0-9]+)(\\.[a-zA-Z0-9_]{1,})*(\\+[a-zA-Z0-9_\\-]{1,})?){1,}@(([a-zA-Z0-9]{2,})(\\.[a-zA-Z]{2,3}){1,2})$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", regexString)
            return predicate.evaluate(with: self)
        }
    }

    func isAlphanumeric() -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[a-zA-Z0-9_]+").evaluate(with: self)
    }

    func stringByAppendingPathComponent(path: String) -> String {
        return (self as NSString).appendingPathComponent(path)
    }

    var localized: String {
        let localized = NSLocalizedString(self, comment: "")
        if !localized.isEmpty {
            return localized
        } else {
            return self
        }
    }

    func englishString() -> String {
        let replace = self.replacingOccurrences(of: "đ", with: "d")
        return replace.folding(options: [.diacriticInsensitive, .widthInsensitive, .caseInsensitive], locale: .current)
    }

    func searchText() -> String {
        return self.lowercased().englishString()
    }

    func isWhiteSpaceOrEmpty() -> Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func trimming() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func digitsOnly() -> String {
        let stringArray = self.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
        let newString = stringArray.joined(separator: "")
        return newString
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }

    static func fromValue(_ value: Any?) -> String? {
        guard let value = value else { return nil }
        return "\(value)"
    }
    
    func utf8DecodedString()-> String {
        let data = self.data(using: .utf8)
        if let message = String(data: data!, encoding: .nonLossyASCII){
            return message
        }
        return ""
    }
    
    func utf8EncodedString()-> String? {
        return String(describing: self.cString(using: String.Encoding.utf8))
    }
    
    func stringByAddingPercentEncodingForRFC3986() -> String? {
        let unreserved = "-._~/?"
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        return self.addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
    }
}

extension Optional where Wrapped == String {
    func isWhiteSpaceOrEmpty() -> Bool {
        return self?.trimmingCharacters(in: .whitespaces).isEmpty ?? true
    }
}

