//
//  BaseViewController.swift
//
//  Created by Dang Nguyen Vu on 11/30/17.
//  Copyright © 2017 Gungnir. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class XViewController: UIViewController {

    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        setupUI()
        setupObservable()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async { [weak self] in
            self?.updateViewSize()
        }
    }
    
    @objc private func back() {
        self.navigationController?.popViewController(animated: true)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        #if DEBUG
        print("+++++++++++++++++++++++\(String(describing: self))")
        #endif
    }

    internal func setupUI() { }

    internal func setupObservable() { }

    internal func bindViewModel() { }

    @objc internal func updateViewSize() { }
}

extension Reactive where Base: XViewController {
    
    var isLoading: Binder<Bool> {
        return Binder(self.base) { _, isLoading in
            if isLoading {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.popActivity()
            }
        }
    }
}
