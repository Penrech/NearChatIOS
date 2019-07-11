//
//  CustomToolbarButton.swift
//  NearChat
//
//  Created by Pau Enrech on 10/07/2019.
//  Copyright © 2019 Pau Enrech. All rights reserved.
//

import UIKit

class CustomToolbarButton: UIButton {

    let buttonHeight = 40
    let buttonIconHeight = 20
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        tintColor = UIColor.defaultBlue
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        tintColor = UIColor.white
    }

}
