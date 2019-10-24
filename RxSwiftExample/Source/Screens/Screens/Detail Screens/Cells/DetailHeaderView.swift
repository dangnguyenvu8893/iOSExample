//
//  DetailHeaderView.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/23/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import UIKit

class DetailHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        nameLabel.textColor = UIColor.white
    }
    
    func bind(name: String) {
        nameLabel.text = name
    }
    
    static func defaultHeight() -> CGFloat {
        return 36.0
    }
}
