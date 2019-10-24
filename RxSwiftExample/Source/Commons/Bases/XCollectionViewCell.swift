//
//  XCollectionViewCell.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/20/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class XCollectionViewCell: UICollectionViewCell {
    
    var bag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
}
