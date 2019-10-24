//
//  DetailViewModel.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/19/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel: XViewModel {
    
    init(movie: Movie, apiUseCase: DetailAPIUseCase = API.shared) {
        movieVar = Variable<Movie>(movie)
        self.apiUseCase = apiUseCase
    }
    
    private var apiUseCase: DetailAPIUseCase
    private var movieVar: Variable<Movie>
}

extension DetailViewModel {
    
    struct Input {
        let viewDidLoad: Driver<Void>
    }
    
    struct Output {
        let reload: Driver<Movie>
        let error: Driver<Error>
        let loading: Driver<Bool>
    }
    
    func transform(_ input: Input, with bag: DisposeBag) -> Output {
        input.viewDidLoad
            .map { [unowned self] _ -> Int? in
                return self.movie.id
            }
            .unwrap()
            .flatMap { [unowned self] id in
                return self.apiUseCase.getMovieDetail(id: id)
                    .trackActivity(self.activityIndicator)
                    .trackError(self.errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .do(onNext: { movie in
                print(movie)
            })
            .drive(movieVar)
            .disposed(by: bag)
        
        return Output(reload: movieVar.asDriver(), error: errorTracker.asDriver(), loading: activityIndicator.asDriver())
    }
}


extension DetailViewModel {
    
    var movie: Movie {
        return movieVar.value
    }
    
    var director: Person? {
        return movieVar.value.director
    }
    
    func numberOfCast() -> Int {
        return movieVar.value.cast.count
    }
    
    func cast(at index: Int) -> Person {
        return movieVar.value.cast[index]
    }
}
