//
//  DetailPresenter.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/24/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailAPIUseCase: class {
    func getMovieDetail(id: Int) -> Observable<Movie>
}
