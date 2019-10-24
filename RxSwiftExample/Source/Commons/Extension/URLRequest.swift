//
//  URLRequest.swift
//
//  Created by Dang Nguyen Vu on 12/25/17.
//  Copyright © 2017 Gungnir. All rights reserved.
//

import Foundation
import Alamofire

extension URLRequest {
    mutating func setHeaders(_ headers: Parameters?) {
        guard let params = headers else {
            return
        }
        for (key, value) in params {
            self.setValue(value as? String, forHTTPHeaderField: key)
        }
    }

    mutating func setParams(_ params: Parameters?) {
        guard let query = params else {
            return
        }
        do {
            self = try URLEncoding.default.encode(self, with: query)
        } catch {
        }
    }

    mutating func setBody(_ params: Parameters?) {
        guard let params = params else { return }
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        httpBody = jsonData
    }
}
