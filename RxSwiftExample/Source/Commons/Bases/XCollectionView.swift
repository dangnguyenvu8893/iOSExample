//
//  XCollectionView.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/20/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class XCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
    }
    
    override func reloadData() {
        super.reloadData()
        refreshControl?.endRefreshing()
    }
}

extension Reactive where Base: XCollectionView {
    
    /**
     Reactive wrapper for `delegate` message `tableView:loadMoreTrigger`.
     */
    var loadMoreTrigger: Driver<Void> {
        return self.willDisplayCell
            .filter({ (_, indexPath) -> Bool in
                return indexPath == self.base.lastIndexPath()
            })
            .asDriverOnErrorJustComplete()
            .throttle(0.3)
            .mapToVoid()
    }
    
    var refreshTrigger: Driver<Void> {
        if base.refreshControl == nil {
            base.setupRefreshControl()
        }
        return self.base.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()
    }
}
