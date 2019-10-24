//
//  BaseViewModel.swift
//
//  Created by Dang Nguyen Vu on 12/9/17.
//  Copyright © 2017 Gungnir. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class XViewModel: NSObject {

    var activityIndicator = ActivityIndicator()
    var errorTracker = ErrorTracker()
    var toastTracker = ToastTracker()

    override init() {
    }
}
