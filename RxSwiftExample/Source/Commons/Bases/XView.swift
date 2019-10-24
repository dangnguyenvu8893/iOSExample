//
//  BaseView.swift
//  Eutopia
//
//  Created by dang.nguyen.vu on 7/19/18.
//  Copyright © 2018 Gungnir. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class XView: UIView {

    var bag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    internal func commonInit() {
        guard let content = Bundle.main.loadNibNamed(className, owner: self, options: nil)?.first as? UIView else {
            return
        }
        content.frame = bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(content)
        backgroundColor = .clear
        setupUI()
        setupObservable()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        #if DEBUG
        print("+++++++++++++++++++++++\(String(describing: self))")
        #endif
    }

    internal func setupUI() {
    }

    internal func setupObservable() {
    }
}
