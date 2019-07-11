//
//  CustomUIViewTouches.swift
//  NearChat
//
//  Created by Pau Enrech on 10/07/2019.
//  Copyright © 2019 Pau Enrech. All rights reserved.
//

import UIKit

class CustomUIViewTouches: UIView {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // Get the hit view we would normally get with a standard UIView
        let hitView = super.hitTest(point, with: event)
        
        // If the hit view was ourself (meaning no subview was touched),
        // return nil instead. Otherwise, return hitView, which must be a subview.
        return hitView == self ? nil : hitView
    }

}
