//
//  CustomVerticalAlignLabel.swift
//  NearChat
//
//  Created by Pau Enrech on 13/07/2019.
//  Copyright © 2019 Pau Enrech. All rights reserved.
//

import UIKit

//Esta clase permite definir la posición vertical en la que se alinea un label
@IBDesignable class CustomVerticalAlignLabel: UILabel {

    //MARK: - variables
    
    //Este enumerador define las diferentes posiciones de alineamiento del texto dentro del label
    enum VerticalAlignment: String {
        case top = "top"
        case middle = "middle"
        case bottom = "bottom"
    }
    
    @IBInspectable var setVerticalAlignment: String = "middle" {
        didSet{
            if let verticalAlignment = VerticalAlignment.init(rawValue: setVerticalAlignment) {
                self.verticalAlignment = verticalAlignment
            }
        }
    }
    
    var verticalAlignment : VerticalAlignment = .top {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //MARK: - métodos sobrescritos
    
    //Esta función es la encargada de realizar el alineamiento del texto dependiendo de la posición elegida
    override public func textRect(forBounds bounds: CGRect, limitedToNumberOfLines: Int) -> CGRect {
        let rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: limitedToNumberOfLines)
        
        if UIView.userInterfaceLayoutDirection(for: .unspecified) == .rightToLeft {
            switch verticalAlignment {
            case .top:
                return CGRect(x: self.bounds.size.width - rect.size.width, y: bounds.origin.y, width: rect.size.width, height: rect.size.height)
            case .middle:
                return CGRect(x: self.bounds.size.width - rect.size.width, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: rect.size.width, height: rect.size.height)
            case .bottom:
                return CGRect(x: self.bounds.size.width - rect.size.width, y: bounds.origin.y + (bounds.size.height - rect.size.height), width: rect.size.width, height: rect.size.height)
            }
        } else {
            switch verticalAlignment {
            case .top:
                return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: rect.size.width, height: rect.size.height)
            case .middle:
                return CGRect(x: bounds.origin.x, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: rect.size.width, height: rect.size.height)
            case .bottom:
                return CGRect(x: bounds.origin.x, y: bounds.origin.y + (bounds.size.height - rect.size.height), width: rect.size.width, height: rect.size.height)
            }
        }
    }
    
    //Esta función es la que, a partir del método anterior, realiza el printado del texto
    override public func drawText(in rect: CGRect) {
        let r = self.textRect(forBounds: rect, limitedToNumberOfLines: self.numberOfLines)
        super.drawText(in: r)
    }

}
