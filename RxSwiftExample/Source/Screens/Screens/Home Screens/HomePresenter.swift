//
//  HomePresenter.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/24/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol HomeRealmUseCase: class {
    func getMovies() -> [Movie]
    func saveMovies(movies: [Movie]) -> Observable<[Movie]>
}

protocol HomeAPIUseCases: class {
    func getUpCommingMovie(page: Int) -> Observable<Response<Movie>>
}

protocol HomeNavigatorUseCase: class {
    func moveToDetail(movie: Movie)
}

extension Navigator: HomeNavigatorUseCase {
    func moveToDetail(movie: Movie) {
        self.push(.detail(movie: movie))
    }
}
