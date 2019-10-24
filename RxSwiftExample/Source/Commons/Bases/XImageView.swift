//
//  XImageView.swift
//  KidsBook
//
//  Created by dang.nguyen.vu on 9/4/18.
//  Copyright © 2018 XStudio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class XImageView: UIImageView {
    
    private var currentLink: String?
    
    func loadImage(_ str: String?, placeholder: UIImage? = nil, callback: ((UIImage?) -> Void)? = nil) {
        currentLink = str
        image = placeholder
        guard let str = str, let url = URL(string: str) else {
            return
        }
        kf.setImage(with: url, placeholder: placeholder, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                callback?(value.image)
            case .failure(_):
                callback?(nil)
            }
        }
    }
}

extension UIImage {
    
    class func downloadImage(with urlString : String?, callback: ((UIImage?) -> Void)?) {
        guard let str = urlString, let url = URL(string: str) else {
            return
        }
        let resource = ImageResource(downloadURL: url)

        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                callback?(value.image)
            case .failure(_):
                callback?(nil)
            }
        }
    }
}

extension Reactive where Base: XImageView {
}
