//
//  DetailOveriewTableViewCell.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/23/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import UIKit

class DetailOveriewTableViewCell: XTableViewCell {

    @IBOutlet private weak var textView: XTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.textColor = .white
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.font = UIFont.boldSystemFont(ofSize: 15.0)
        textView.textAlignment = .justified
    }
    
    func bind(movie: Movie) {
        textView.text = movie.overview
    }

    static func defaultHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
}
