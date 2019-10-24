//
//  ToastTracker.swift
//  Translator
//
//  Created by XStudio on 3/23/19.
//  Copyright © 2019 XStudio. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ToastTracker {
    
    private let _subject = PublishSubject<String>()
    
    func onNext(text: String) {
        _subject.onNext(text)
    }
    
    func asDriver() -> Driver<String> {
        return _subject.asDriverOnErrorJustComplete()
    }
}
