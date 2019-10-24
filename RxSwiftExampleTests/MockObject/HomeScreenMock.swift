//
//  HomeScreenMock.swift
//  RxSwiftExampleTests
//
//  Created by Vu Dang on 10/24/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
@testable import RxSwiftExample

class HomeScreenMockData {
    
    var mockDataFromAPI: ((Int) -> Observable<Response<Movie>>)!
    
    var mockDataFromRealm: (() -> [Movie])!
    
    var isCallMoveToDetailNavigator = false
    var isCallSaveMovieToRealm = false
    var lastestLoaderPage = 0
    
    var defaultMovie: [Movie] = {
        var movie = Movie()
        movie.posterPath = "/vqzNJRH4YyquRiWxCCOH0aXggHI.jpg"
        movie.id = 157336
        movie.originalTitle = "Terminator: Dark Fate"
        
        var movie2 = Movie()
        movie2.posterPath = "/uTALxjQU8e1lhmNjP9nnJ3t2pRU.jpg"
        movie2.originalTitle = "Gemini Man"
        movie2.id = 290859
        
        var movie3 = Movie()
        movie3.posterPath = "/zfE0R94v1E8cuKAerbskfD3VfUt.jpg"
        movie3.originalTitle = "It Chapter Two"
        movie3.id = 474350
        
        var movie4 = Movie()
        movie4.posterPath = "/pIcV8XXIIvJCbtPoxF9qHMKdRr2.jpg"
        movie4.originalTitle = "Zombieland: Double Tap"
        movie4.id = 338967
        
        return [movie, movie2, movie3, movie4]
    }()
}

extension HomeScreenMockData: HomeAPIUseCases {
    
    func getUpCommingMovie(page: Int) -> Observable<Response<Movie>> {
        lastestLoaderPage = page
        return mockDataFromAPI(page)
    }
}

extension HomeScreenMockData: HomeNavigatorUseCase {

    func moveToDetail(movie: Movie) {
        isCallMoveToDetailNavigator = true
    }
}

extension HomeScreenMockData: HomeRealmUseCase {

    func getMovies() -> [Movie] {
        return mockDataFromRealm()
    }

    func saveMovies(movies: [Movie]) -> Observable<[Movie]> {
        isCallSaveMovieToRealm = true
        return Observable.just(movies)
    }
}
