//
//  Observable + Extension.swift
//  KidsBook
//
//  Created by Dang Nguyen Vu on 9/21/18.
//  Copyright © 2018 XStudio. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Observable {
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
    
    func catchErrorJustComplete() -> Observable<E> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver { _ in
            return Driver.empty()
        }
    }

    func unwrap<T>() -> Observable<T> where Element == T? {
        return self.filter { $0 != nil }.map { $0! }
    }
}
