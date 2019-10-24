//
//  API.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/19/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import RxCocoa
import ObjectMapper

class API {
    
    static var shared = API()
    
    enum APIError: Error {
        case normal
        case networkDown
        
        var localizedDescription: String {
            switch self {
            case .normal:
                return "Something Wrong"
            case .networkDown:
                return "Internet problem"
            }
        }
    }
    
    var configuration: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30.0
        config.timeoutIntervalForResource = 30.0
        return config
    }
    
    lazy var sessionManager: SessionManager = {
        return SessionManager(configuration: configuration)
    }()
    
    func handleError(resError: Error) -> Error? {
        guard let error = resError as? URLError else {
            return nil
        }
        if error.code == .notConnectedToInternet {
            return APIError.networkDown
        } else {
            return error
        }
    }
    
    func request<T: Mappable>(urlRequest: URLRequestConvertible) -> Observable<T> {
        return sessionManager.rx
            .request(urlRequest: urlRequest)
            .responseJSON()
            .catchError({ [unowned self] error -> Observable<DataResponse<Any>> in
                guard let apiError = self.handleError(resError: error) else {
                    return Observable<DataResponse<Any>>.error(error)
                }
                return Observable<DataResponse<Any>>.error(apiError)
            }).flatMap({ response -> Observable<T> in
                guard let data = response.result.value as? [String: Any] else { return Observable<T>.error(APIError.normal)}
                guard let object = Mapper<T>().map(JSON: data) else { return Observable<T>.error(APIError.normal)}
                return Observable.just(object)
            })
    }
    
    func requestArray<T: Mappable>(urlRequest: URLRequestConvertible) -> Observable<Response<T>> {
        return sessionManager.rx
            .request(urlRequest: urlRequest)
            .responseJSON()
            .catchError({ [unowned self] error -> Observable<DataResponse<Any>> in
                guard let apiError = self.handleError(resError: error) else {
                    return Observable<DataResponse<Any>>.error(error)
                }
                return Observable<DataResponse<Any>>.error(apiError)
            }).flatMap({ response -> Observable<Response<T>> in
                guard let data = response.result.value as? [String: Any],
                    let object = Mapper<Response<T>>().map(JSON: data) else {
                    return Observable<Response<T>>.error(APIError.normal)
                }
                return Observable.just(object)
            })
    }
}
