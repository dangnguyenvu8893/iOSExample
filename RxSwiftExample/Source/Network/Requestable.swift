//
//  Requestable.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/19/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import Alamofire

protocol Requestable: URLRequestConvertible {
    
    var method: HTTPMethod { get }
    var path: String { get }
    var header: Parameters? { get }
    var params: Parameters? { get }
    var body: Parameters? { get }
}

extension Requestable {
    
    var method: HTTPMethod { return .get }
    var path: String { return "" }
    var header: Parameters? { return nil }
    var params: Parameters? { return nil }
    var body: Parameters? { return nil }
    
    private var defaultHeader: Parameters? {
        let param = ["Content-Type": "application/json"]
        return param
    }
    
    private var defaultParam: Parameters? {
        let param = ["api_key": APIConfig.key]
        return param
    }
    
    var request: URLRequest {
        var url = URL(string: "\(APIConfig.host)/\(APIConfig.version)")!
        url.appendPathComponent("/\(path)")
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setHeaders(defaultHeader)
        request.setHeaders(header)
        request.setParams(defaultParam)
        request.setParams(params)
        request.setBody(body)
        return request
    }
    
    func asURLRequest() throws -> URLRequest {
        return request
    }
}

