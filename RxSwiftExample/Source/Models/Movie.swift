//
//  Movie.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/19/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import ObjectMapper

struct Movie {
    
    var id: Int?
    var homePage: String?
    var imdbId: String?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var posterPath: String?
    var releaseDate: Date?
    var status: Status?
    var genres: [Genre] = []
    var voteAverage: Double?
    var popularity: Double?
    var runtime: Int?
    var videos: [Video] = []
    var backdrops: [Image] = []
    var posters: [Image] = []
    var cast: [Person] = []
    var crew: [Person] = []
    var director: Person? {
        return crew.first(where: {$0.job == "Director"})
    }
}

extension Movie {
    
    enum Status: String, CaseIterable {
        case rumored = "Rumored"
        case planned = "Planned"
        case inProduction = "In Production"
        case postProduction = "Post Production"
        case canceled = "Canceled"
        case release = "Released"
        
        static var transform: TransformOf<Status, String> {
            return TransformOf<Status, String>(fromJSON: { str -> Movie.Status? in
                return Status(rawValue: str ?? "")
            }, toJSON: { status -> String? in
                return status?.rawValue
            })
        }
    }
}

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Movie: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        homePage <- map["homePage"]
        imdbId <- map["imdb_id"]
        originalLanguage <- map["original_language"]
        originalTitle <- map["original_title"]
        overview <- map["overview"]
        posterPath <- map["poster_path"]
        releaseDate <- (map["release_date"], DateFormatterTransform(dateFormatter: XDate.shared.formatter))
        status <- (map["status"], Status.transform)
        genres <- map["genres"]
        voteAverage <- map["vote_average"]
        popularity <- map["popularity"]
        runtime <- map["runtime"]
        videos <- map["videos"]
        backdrops <- map["images.backdrops"]
        posters <- map["images.posters"]
        cast <- map["credits.cast"]
        crew <- map["credits.crew"]
    }
}
