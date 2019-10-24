//
//  XTableView.swift
//  KidsBook
//
//  Created by Dang Nguyen Vu on 9/5/18.
//  Copyright © 2018 XStudio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class XTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        separatorStyle = .none
    }

    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
    }

    override func reloadData() {
        super.reloadData()
        refreshControl?.endRefreshing()
    }
}

extension Reactive where Base: XTableView {

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
