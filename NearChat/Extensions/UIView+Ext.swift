//
//  UIView+Ext.swift
//  NearChat
//
//  Created by Pau Enrech on 12/07/2019.
//  Copyright © 2019 Pau Enrech. All rights reserved.
//

import UIKit

//La función de esta extensión es la de ocultar o mostrar un determinado view, imitando
//el sistema de visibilidad de elementos de Android
extension UIView {
    
    //Este enumerador muestra las diferentes opciones de visibilidad
    enum Visibility: String {
        case visible = "visible"
        case invisible = "invisible"
        case gone = "gone"
    }
    
    var visibility: Visibility {
        get {
            let constraint = (self.constraints.filter{$0.firstAttribute == .height && $0.constant == 0}.first)
            if let constraint = constraint, constraint.isActive {
                return .gone
            } else {
                return self.isHidden ? .invisible : .visible
            }
        }
        set {
            if self.visibility != newValue {
                self.setVisibility(newValue)
            }
        }
    }
    
    @IBInspectable
    var visibilityState: String {
        get {
            return self.visibility.rawValue
        }
        set {
            let _visibility = Visibility(rawValue: newValue)!
            self.visibility = _visibility
        }
    }
    
    //Esta función es la que propiamente cambia la visibilidad de un elemento.
    //Por un lado oculta o muestra al elemento cuando es necesario
    //Por otro lado, se modifica el constraint que determina el tamaño del elemento a 0 o al valor por defecto para eliminar o ampliar su espacio
    //Finalmente se modifica el constraint de su margen derecho con respecto a otros elementos para eliminar o ampliar su espacio
    //Pese a que esta extensión esta disponible de todos los elementos, esta pensada para los elementos custom de los diferentes
    //toolbar de la aplicación. 
    private func setVisibility(_ visibility: Visibility) {
        let constraints = self.constraints.filter({$0.firstAttribute == .height && $0.constant == 0 && $0.secondItem == nil && ($0.firstItem as? UIView) == self})
        let constraint = (constraints.first)
        let trailingConstraints = self.superview?.constraints.filter({($0.secondItem as? UIView) == self})
        let trailingConstraint = trailingConstraints?.first
        
        switch visibility {
        case .visible:
            trailingConstraint?.constant = 12
            constraint?.isActive = false
            self.isHidden = false
            self.subviews.first?.isHidden = false
            break
        case .invisible:
            trailingConstraint?.constant = 12
            constraint?.isActive = false
            self.isHidden = true
            self.subviews.first?.isHidden = false
            break
        case .gone:
            self.isHidden = true
            if let constraint = constraint {
                constraint.isActive = true
            } else {
                let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0)
                self.addConstraint(constraint)
                constraint.isActive = true
            }
            if let trailingConstraint = trailingConstraint {
              trailingConstraint.constant = 0
              self.superview?.setNeedsLayout()
              self.superview?.setNeedsUpdateConstraints()
            }
            self.setNeedsLayout()
            self.setNeedsUpdateConstraints()
        }
    }
}
