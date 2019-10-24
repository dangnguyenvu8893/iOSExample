//
//  UITableView.swift
//  airCloset
//
//  Created by Shohei Ohno on 2016/01/26.
//  Copyright © 2016年 Gungnir. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_ type: T.Type) {
        let className = type.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }

    func dequeueCell<T: UITableViewCell>(_ type: T.Type) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className) as! T
    }

    func dequeueCell<T: UITableViewCell>(_ type: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }

    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ type: T.Type) {
        let nib = UINib(nibName: type.className, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: type.className)
    }

    func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(_ type: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: type.className) as! T
    }

    func cellAtIndex<T: UITableViewCell>(_ type: T.Type, row: Int = 0, section: Int = 0) -> T {
        return cellForRow(at: IndexPath(row: row, section: section)) as! T
    }

    func cellAtOptionalIndex<T: UITableViewCell>(_ type: T.Type, row: Int = 0, section: Int = 0) -> T? {
        return cellForRow(at: IndexPath(row: row, section: section)) as? T
    }

    func setSeparetorZero(_ cell: UITableViewCell) {
        if responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            separatorInset = UIEdgeInsets.zero
        }

        if responds(to: #selector(setter: UIView.layoutMargins)) {
            layoutMargins = UIEdgeInsets.zero
        }

        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }

    func reloadDataAfter(_ completion: (() -> Void)? = nil) {
        reloadData()
        guard let comp = completion else { return }
        DispatchQueue.main.async(execute: { comp() })
    }

    func isLastCell(at indexPath: IndexPath) -> Bool {
        return indexPath.row == (numberOfRows(inSection: indexPath.section) - 1)
    }

    func isLastSectionAndLastRow(at indexPath: IndexPath) -> Bool {
        return indexPath.section == (numberOfSections - 1) && isLastCell(at: indexPath)
    }

    func lastIndexPath() -> IndexPath? {
        for index in (0 ..< numberOfSections).reversed() {
            if numberOfRows(inSection: index) > 0 {
                return IndexPath(row: numberOfRows(inSection: index) - 1, section: index)
            }
        }
        return nil
    }

    func scrollToBottom(animated: Bool) {
        guard let indexPath = lastIndexPath() else {
            return
        }
        scrollToRow(at: indexPath, at: .bottom, animated: animated)
    }
}

