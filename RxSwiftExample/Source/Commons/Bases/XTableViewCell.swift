//
//  XTableViewCell.swift
//  KidsBook
//
//  Created by dang.nguyen.vu on 9/4/18.
//  Copyright © 2018 XStudio. All rights reserved.
//

import UIKit
import Material
import RxSwift
import RxCocoa

class XTableViewCell: TableViewCell {
    
    var bag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
}
