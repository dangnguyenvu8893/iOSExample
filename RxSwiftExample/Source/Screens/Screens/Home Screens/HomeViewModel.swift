//
//  HomeViewModel.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/19/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxRealm
import RealmSwift

class HomeViewModel: XViewModel {
    
    private var moviesVar = Variable<[Movie]>([])
    private var currentResponse = Variable<Response<Movie>?>(nil)
}

extension HomeViewModel {
    
    struct Input {
        var viewDidLoadTrigger: Driver<Void>
        var tableDidRefresh: Driver<Void>
        var tableDidLoadmore: Driver<Void>
        var didTapCellAtIndex: Driver<Int>
    }
    
    struct Output {
        var reload: Driver<[Movie]>
        var error: Driver<Error>
        var loading: Driver<Bool>
    }
    
    func transform(_ input: Input, with bag: DisposeBag) -> Output {
        let sorfReleaseDateMovie: (([Movie]) -> Driver<[Movie]>) = { movies in
            return Driver.just(movies).map { movies -> [Movie] in
                return movies.sorted(by: { (first, second) -> Bool in
                    guard let fDate = first.releaseDate, let sDate = first.releaseDate else { return false }
                    return fDate < sDate
                })
            }
        }
        
        // First Load And Trigger
        let didLoadFromRealm = input.viewDidLoadTrigger
            .map { _ -> [Movie] in
                return RealmCore.shared.getMovies()
            }
            .flatMap(sorfReleaseDateMovie)
            .do(moviesVar)

        let refreshTrigger = Driver.merge([didLoadFromRealm.mapToVoid(), input.tableDidRefresh])

        refreshTrigger
            .flatMap({ [unowned self] _ -> Driver<Response<Movie>> in
                return API.shared.getUpCommingMovie(page: 1)
                    .trackActivity(self.activityIndicator)
                    .trackError(self.errorTracker)
                    .asDriverOnErrorJustComplete()
            })
            .do(onNext: { [unowned self] response in
                self.currentResponse.value
                    = response
            })
            .map({ response -> [Movie] in
                return response.results
            })
            .flatMap(sorfReleaseDateMovie)
            .do(moviesVar)
//            .asObservable()
//            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
//            .map({ movies -> Observable<[Movie]> in
//                return RealmCore.shared.saveMovies(movies: movies)
//            })
//            .subscribe()
            .flatMap({ movies -> Driver<[Movie]> in
                return RealmCore.shared
                    .saveMovies(movies: movies)
                    .asDriverOnErrorJustComplete()
            })
            .drive()
            .disposed(by: bag)
        
        // Loadmore
        input.tableDidLoadmore
            .withLatestFrom(currentResponse.asDriver())
            .filter({ res -> Bool in
                return res?.totalPages != nil && res?.page != nil
            })
            .map { res -> Int in
                return res!.page! + 1
            }
            .unwrap()
            .filter { [unowned self] current -> Bool in
                return current < self.currentResponse.value!.totalPages!
            }
            .flatMap { [unowned self] currentPage -> Driver<Response<Movie>> in
                return API.shared.getUpCommingMovie(page: currentPage)
                    .trackActivity(self.activityIndicator)
                    .trackError(self.errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .do(onNext: { [unowned self] response in
                self.currentResponse.value
                    = response
            })
            .map({ response -> [Movie] in
                return response.results
            })
            .do(onNext: { [unowned self] newMovies in
                self.moviesVar.value.replace(newMovies)
            })
            .do(onNext: { movies in
                return RealmCore.shared.saveMovies(movies: movies)
            })
            .drive()
            .disposed(by: bag)
        
        input.didTapCellAtIndex
            .map { [unowned self] index -> Movie in
                return self.moviesVar.value[index]
            }
            .drive(onNext: { movie in
                Navigator.shared.push(.detail(movie: movie))
            })
            .disposed(by: bag)

        let reloadData = moviesVar.asDriver()
        return Output(reload: reloadData,
                      error: errorTracker.asDriver(),
                      loading: activityIndicator.asDriver())
    }
}

extension HomeViewModel {
    
    func numberOfItem() -> Int {
        return moviesVar.value.count
    }
    
    func itemAt(_ index: Int) -> Movie {
        return moviesVar.value[index]
    }
}
