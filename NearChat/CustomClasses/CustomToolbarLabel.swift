//
//  CustomToolbarLabel.swift
//  NearChat
//
//  Created by Pau Enrech on 12/07/2019.
//  Copyright © 2019 Pau Enrech. All rights reserved.
//

import UIKit

//Esta clase permite guardar todos los métodos y propiedades necesarias para el Label del
//título del toolbar pueda ser animado dinámicamente
@IBDesignable class CustomToolbarLabel: UILabel {
    
    //MARK: - variables
    
    let labelHeight: CGFloat = 40.0
    let defaultColor = UIColor.defaultBrokenBlack
    var elementPrinted = false
    var leftPercentage: CGFloat? = nil
    var visible: Visibility = .visible
    
    var boundaries: CGRect? {
        didSet{
            if let boundaries = boundaries, let screenWidth = superview?.frame.width {
                leftPercentage = boundaries.minX / screenWidth
            }
        }
    }
    
    @IBInspectable var alphaValueStored: CGFloat = 1.0 {
        didSet{
            alphaValueStored = min(max(alphaValueStored, 0.0), 1.0)
        }
    }
    
    //MARK: - métodos sobrescritos
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !elementPrinted {
            getBoundaries()
            elementPrinted = true
        }
    }
    
    //MARK: - métodos
    
    //Este método permite asignar al alpha del label
    func setAlpha(){
        alpha = alphaValueStored
    }
    
    //Este método permite obtener la posición exacta del label en la pantalla
    private func getBoundaries(){
        boundaries = self.superview?.convert(self.frame, from: self.superview)
    }
    
    //Esta función permite cambiar de una vez todos los parámetros visuales del label
    func applyUIChanges(){
        setAlpha()
    }
  
}
