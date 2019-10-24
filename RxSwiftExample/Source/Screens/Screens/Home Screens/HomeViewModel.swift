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
    
    private var realmUseCase: HomeRealmUseCase
    private var apiUseCase: HomeAPIUseCases
    private var navigatorUseCase: HomeNavigatorUseCase
    
    private var moviesVar = Variable<[Movie]>([])
    private var currentResponse = Variable<Response<Movie>?>(nil)
    private var realm = try! Realm()
    
    init(realmUseCase: HomeRealmUseCase = RealmCore.shared,
         apiUseCase: HomeAPIUseCases = API.shared,
         navigatorUseCase: HomeNavigatorUseCase = Navigator.shared) {
        self.realmUseCase = realmUseCase
        self.apiUseCase = apiUseCase
        self.navigatorUseCase = navigatorUseCase
    }
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
            .map { [unowned self] _ -> [Movie] in
                return self.realmUseCase.getMovies()
            }
            .flatMap(sorfReleaseDateMovie)
            .do(moviesVar)

        let refreshTrigger = Driver.merge([didLoadFromRealm.mapToVoid(), input.tableDidRefresh])

        refreshTrigger
            .flatMap({ [unowned self] _ -> Driver<Response<Movie>> in
                return self.apiUseCase.getUpCommingMovie(page: 1)
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
            .flatMap({ [unowned self] movies -> Driver<[Movie]> in
                return self.realmUseCase
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
                return self.apiUseCase.getUpCommingMovie(page: currentPage)
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
            .map { movies -> [MovieRealm] in
                return movies.map({MovieRealm.create(with: $0)})
            }
            .drive(realm.rx.add(update: true, onError: nil))
            .disposed(by: bag)
        
        input.didTapCellAtIndex
            .map { [unowned self] index -> Movie in
                return self.moviesVar.value[index]
            }
            .drive(onNext: { [unowned self] movie in
                self.navigatorUseCase.moveToDetail(movie: movie)
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
