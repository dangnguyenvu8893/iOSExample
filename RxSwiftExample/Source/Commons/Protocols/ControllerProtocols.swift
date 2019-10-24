//
//  ControllerProtocols.swift
//  SpecialSymbols
//
//  Created by dang.nguyen.vu on 6/18/18.
//  Copyright © 2018 Gungnir. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ViewModelViewController: class {
    associatedtype ViewModel: XViewModel
    var viewModel: ViewModel! {get set}
}

extension ViewModelViewController where Self: UIViewController {
    
    static func createWith(_ viewModel: ViewModel) -> Self {
        let controller = Self(nibName: self.className, bundle: nil)
        controller.viewModel = viewModel
        return controller
    }
}
