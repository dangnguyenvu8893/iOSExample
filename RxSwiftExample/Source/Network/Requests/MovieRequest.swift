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
    
    case upcoming(page: Int)
    case movie(id: Int)
    
    var path: String {
        switch self {
        case .upcoming:
            return "movie/upcoming"
        case .movie(let id):
            return "movie/\(id)"
        }
    }
    
    var params: Parameters? {
        var params = [String: String]()
        switch self {
        case .upcoming(let page):
            params["page"] = "\(page)"
        case .movie:
            params["append_to_response"] = "videos,images,credits"
        }
        return params
    }
}

extension API: HomeAPIUseCases, DetailAPIUseCase {
    func getMovieDetail(id: Int) -> Observable<Movie> {
        let request = MovieRequest.movie(id: id)
        return API.shared.request(urlRequest: request)
    }
    
    func getUpCommingMovie(page: Int = 1) -> Observable<Response<Movie>> {
        let request = MovieRequest.upcoming(page: page)
        return API.shared.requestArray(urlRequest: request)
    }
}
