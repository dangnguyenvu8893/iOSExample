//
//  DetailPersonTableViewCell.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/23/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import UIKit

class DetailPersonTableViewCell: XTableViewCell {

    @IBOutlet private weak var profileImageView: XImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ruleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.roundView()
        profileImageView.contentMode = .scaleAspectFill
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        nameLabel.textColor = .white
        ruleLabel.textColor = .lightGray
        ruleLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
    }

    func bind(person: Person?, isDirection: Bool) {
        guard let person = person else { return }
        let profileStr = ImageManager.getImageString(size: ImageManager.ProfileSize.w185, path: person.profilePath)
        profileImageView.loadImage(profileStr)
        nameLabel.text = person.name
        ruleLabel.text = isDirection ? person.job : person.character
    }

    static func defaultHeight() -> CGFloat {
        return 80.0
    }
}
