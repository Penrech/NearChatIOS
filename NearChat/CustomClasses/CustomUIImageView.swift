//
//  CustomUIImageView.swift
//  NearChat
//
//  Created by Pau Enrech on 13/07/2019.
//  Copyright © 2019 Pau Enrech. All rights reserved.
//

import UIKit

//La función de este clase es la de crear un imageview circular
@IBDesignable class CustomUIImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
}
