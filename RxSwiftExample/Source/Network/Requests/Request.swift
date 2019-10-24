//
//  MovieRequest.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/19/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import RxSwift
import RxCocoa

enum MovieRequest: Requestable {
    
    case upcomming
    case movie(id: Int)
    
    var path: String {
        switch self {
        case .upcomming:
            return "movie"
        case .movie(let id):
            return "movie/\(id)"
        }
    }
    
    var params: Parameters? {
        switch self {
        case .movie:
            return ["append_to_response": "videos, images, credits"]
        }
    }
}

extension API {
    static func getMovieDetail(id: Int) -> Observable<Movie> {
        let request = MovieRequest.movie(id: id)
        return API.request(urlRequest: request)
    }
}
