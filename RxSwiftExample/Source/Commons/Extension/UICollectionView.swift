//
//  UICollectionView.swift
//
//  Created by Dang Nguyen Vu on 7/20/17.
//  Copyright © 2017 s0hno. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(_ type: T.Type) {
        let className = type.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: className)
    }

    // swiftlint:disable force_cast
    func dequeueCell<T: UICollectionViewCell>(_ type: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }

    // swiftlint:disable force_cast
    func cellAtIndex<T: UICollectionViewCell>(_ type: T.Type, row: Int = 0, section: Int = 0) -> T? {
        return cellForItem(at: IndexPath(row: row, section: section)) as? T
    }

    func reloadDataAfter(_ completion: (() -> Void)? = nil) {
        reloadData()
        guard let comp = completion else { return }
        DispatchQueue.main.async(execute: { comp() })
    }

    func lastIndexPath() -> IndexPath? {
        for index in (0 ..< numberOfSections).reversed() {
            if numberOfItems(inSection: index) > 0 {
                return IndexPath(item: numberOfItems(inSection: index) - 1, section: index)
            }
        }
        return nil
    }
}

extension UICollectionViewCell {
    /// This is a workaround method for self sizing collection view cells which stopped working for iOS 12
    func setupSelfSizingForiOS12(contentView: UIView) {
        if #available(iOS 12, *) {
            contentView.translatesAutoresizingMaskIntoConstraints = false
            let leftConstraint = contentView.leftAnchor.constraint(equalTo: leftAnchor)
            let rightConstraint = contentView.rightAnchor.constraint(equalTo: rightAnchor)
            let topConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
            let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            NSLayoutConstraint.activate([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
        }
    }
}
