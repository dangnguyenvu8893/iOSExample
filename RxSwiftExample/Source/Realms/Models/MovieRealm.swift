//
//  MovieRealm.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/20/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import RealmSwift

class MovieRealm: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var homePage: String? = nil
    @objc dynamic var imdbId: String? = nil
    @objc dynamic var originalLanguage: String? = nil
    @objc dynamic var originalTitle: String? = nil
    @objc dynamic var posterPath: String? = nil
    @objc dynamic var releaseDate: Date? = nil
    @objc dynamic var status: String? = nil
    @objc dynamic var overview: String? = nil
    @objc dynamic var runtime: Int = 0
    dynamic var genres = List<GenreRealm>()
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var popularity: Double = 0.0
    dynamic var videos = List<VideoRealm>()
    dynamic var backdrops = List<ImageRealm>()
    dynamic var posters = List<ImageRealm>()
    dynamic var cast = List<PersonRealm>()
    dynamic var crew = List<PersonRealm>()
    
    static func create(with movie: Movie) -> MovieRealm {
        let obj = MovieRealm()
        obj.id = movie.id ?? 0
        obj.homePage = movie.homePage
        obj.imdbId = movie.imdbId
        obj.originalLanguage = movie.originalLanguage
        obj.originalTitle = movie.originalTitle
        obj.overview = movie.overview
        obj.posterPath = movie.posterPath
        obj.releaseDate = movie.releaseDate
        obj.voteAverage = movie.voteAverage ?? 0.0
        obj.popularity = movie.popularity ?? 0.0
        obj.status = movie.status?.rawValue ?? ""
        obj.genres.append(objectsIn: movie.genres.map({GenreRealm.create(with: $0)}))
        obj.videos.append(objectsIn: movie.videos.map({VideoRealm.create(with: $0)}))
        obj.backdrops.append(objectsIn: movie.backdrops.map({ImageRealm.create(with: $0)}))
        obj.posters.append(objectsIn: movie.posters.map({ImageRealm.create(with: $0)}))
        obj.cast.append(objectsIn: movie.cast.map({PersonRealm.create(with: $0)}))
        obj.crew.append(objectsIn: movie.crew.map({PersonRealm.create(with: $0)}))
        return obj
    }
    
    var movie: Movie {
        let genreList = Array(self.genres.map({$0.genre}))
        let videoList = Array(self.videos.map({$0.video}))
        let backdropList = Array(self.backdrops.map({$0.image}))
        let posterList = Array(self.posters.map({$0.image}))
        let castList = Array(self.cast.map({$0.person}))
        let crewList = Array(self.crew.map({$0.person}))
        return Movie(id: id,
                     homePage: homePage,
                     imdbId: imdbId,
                     originalLanguage: originalLanguage,
                     originalTitle: originalTitle,
                     overview: overview,
                     posterPath: posterPath,
                     releaseDate: releaseDate,
                     status: Movie.Status(rawValue: status ?? ""),
                     genres: genreList,
                     voteAverage: voteAverage,
                     popularity: popularity,
                     runtime: runtime,
                     videos: videoList,
                     backdrops: backdropList,
                     posters: posterList,
                     cast: castList,
                     crew: crewList)
    }

    override class func primaryKey() -> String? {
        return "id"
    }
}
