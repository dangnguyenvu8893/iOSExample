//
//  MovieCollectionViewCell.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/20/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var posterImageView: XImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.contentMode = .scaleAspectFit
    }

    func configure(_ item: Movie) {
        let imageStr = ImageManager.getImageString(size: ImageManager.PosterSize.w185, path: item.posterPath)
        posterImageView.loadImage(imageStr)
    }

    static var ratio: CGFloat = 1.5
}
