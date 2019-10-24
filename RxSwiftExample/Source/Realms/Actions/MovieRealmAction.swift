//
//  MovieRealmAction.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/22/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm
import RxSwift
import RxCocoa

extension RealmCore {

    func getMovies() -> [Movie] {
        return realm.objects(MovieRealm.self).map({$0.movie})
    }

    func saveMovies(movies: [Movie]) -> Observable<[Movie]> {
        return Observable
            .just(movies)
            .do(onNext: { [unowned self] movies in
                let objs = movies.map({MovieRealm.create(with: $0)})
                try! self.realm.write {
                    self.realm.add(objs, update: .all)
                }
            })
    }
}
