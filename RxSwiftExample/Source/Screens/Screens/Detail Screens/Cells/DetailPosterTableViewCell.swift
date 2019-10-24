//
//  DetailPosterTableViewCell.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/23/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import UIKit

class DetailPosterTableViewCell: XTableViewCell {

    @IBOutlet private weak var posterImageView: XImageView!
    @IBOutlet private weak var posterWidthC: NSLayoutConstraint!
    @IBOutlet private weak var posterHeightC: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.contentMode = .scaleAspectFill
    }

    func bind(_ movie: Movie) {
        let imageStr = ImageManager.getImageString(size: ImageManager.PosterSize.w780, path: movie.posterPath)
        posterImageView.loadImage(imageStr) { [weak self] image in
            guard let self = self, let image = image else { return }
            let ratio = image.size.height / image.size.width
            let height = self.posterWidthC.constant * ratio
            self.posterHeightC.constant = height
            self.layoutIfNeeded()
        }
    }

    static func defaultHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
}
