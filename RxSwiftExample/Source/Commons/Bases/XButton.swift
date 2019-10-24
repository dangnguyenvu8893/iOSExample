//
//  XButton.swift
//  Translator
//
//  Created by XStudio on 3/1/19.
//  Copyright © 2019 XStudio. All rights reserved.
//

import Foundation
import Material

class XButton: FlatButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        pulseColor = UIColor.gray
    }
}
