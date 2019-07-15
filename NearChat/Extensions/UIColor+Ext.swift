//
//  UIColor+Ext.swift
//  NearChat
//
//  Created by Pau Enrech on 04/07/2019.
//  Copyright © 2019 Pau Enrech. All rights reserved.
//

import UIKit

extension UIColor {
    
    //MARK: - propiedades estáticas
    //Defino todos los colores de la app
    
    static let defaultBrokenBlack = UIColor(rojo: 77, verde: 77, azul: 77)
    static let defaultBrokenGray = UIColor(rojo: 102, verde: 102, azul: 102)
    static let defaultDarkBlue = UIColor(rojo: 3, verde: 169, azul: 244)
    static let defaultLightBlue = UIColor(rojo: 179, verde: 229, azul: 252)
    static let defaultBlue = UIColor(rojo: 129, verde: 212, azul: 250)
    static let defaultGreen = UIColor(rojo: 165, verde: 214, azul: 167)
    static let defaultYellow = UIColor(rojo: 255, verde: 245, azul: 157)
    static let defaultRed = UIColor(rojo: 255, verde: 171, azul: 145)
    
    static let random1 = UIColor(rojo: 239, verde: 154, azul: 154)
    static let random2 = UIColor(rojo: 244, verde: 143, azul: 177)
    static let random3 = UIColor(rojo: 206, verde: 147, azul: 216)
    static let random4 = UIColor(rojo: 179, verde: 157, azul: 219)
    static let random5 = UIColor(rojo: 159, verde: 168, azul: 218)
    static let random6 = UIColor(rojo: 144, verde: 202, azul: 249)
    static let random7 = UIColor(rojo: 129, verde: 212, azul: 250)
    static let random8 = UIColor(rojo: 128, verde: 222, azul: 234)
    static let random9 = UIColor(rojo: 128, verde: 203, azul: 196)
    static let random10 = UIColor(rojo: 165, verde: 214, azul: 167)
    static let random11 = UIColor(rojo: 197, verde: 225, azul: 165)
    static let random12 = UIColor(rojo: 230, verde: 238, azul: 156)
    static let random13 = UIColor(rojo: 255, verde: 245, azul: 157)
    static let random14 = UIColor(rojo: 255, verde: 224, azul: 130)
    static let random15 = UIColor(rojo: 255, verde: 204, azul: 128)
    static let random16 = UIColor(rojo: 255, verde: 171, azul: 145)
    
    //MARK: - funciones útiles
    
    //Recibo un color aleatorio de los colores de la app
    func getRandomColor() -> UIColor {
        let random = Int.random(in: 0 ... 15)
        let options = [UIColor.random1, UIColor.random2, UIColor.random3, UIColor.random4, UIColor.random5, UIColor.random6, UIColor.random7, UIColor.random8,
                       UIColor.random9, UIColor.random10, UIColor.random11, UIColor.random12, UIColor.random13, UIColor.random14, UIColor.random15,
                       UIColor.random16]
        
        return options[random]
    }
    
    //Este método devuelve un color entre el color inicial y un segundo color en el porcentaje del 0 al 1
    //determinado, siendo 0 el color inicial y 1 el segundo color
    func toColor(_ color: UIColor, percentage: CGFloat) -> UIColor {
        let percentage = max(min(percentage, 100), 0) / 100
        switch percentage {
        case 0: return self
        case 1: return color
        default:
            var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            guard self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1) else { return self }
            guard color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2) else { return self }
            
            return UIColor(red: CGFloat(r1 + (r2 - r1) * percentage),
                           green: CGFloat(g1 + (g2 - g1) * percentage),
                           blue: CGFloat(b1 + (b2 - b1) * percentage),
                           alpha: CGFloat(a1 + (a2 - a1) * percentage))
        }
    }
    
    //MARK: - init alternativo
    
    convenience init(rojo: Int, verde: Int, azul: Int){
        let valorRojo = CGFloat(rojo)/255.0
        let valorVerde = CGFloat(verde)/255.0
        let valorAzul = CGFloat(azul)/255.0
        self.init(red: valorRojo, green: valorVerde, blue: valorAzul, alpha: 1.0)
    }
    
}
