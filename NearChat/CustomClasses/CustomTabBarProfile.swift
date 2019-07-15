//
//  CustomTabBarProfile.swift
//  NearChat
//
//  Created by Pau Enrech on 13/07/2019.
//  Copyright © 2019 Pau Enrech. All rights reserved.
//

import UIKit

@IBDesignable class CustomTabBarProfile: UITabBar {

    //MARK: - propiedades
    
    //Altura de la tabBar
    let tabBarHeight: CGFloat = 58.0
    
    @IBInspectable var barBackgroundColor: UIColor = UIColor.defaultDarkBlue {
        didSet{
            backgroundColor = barBackgroundColor
        }
    }
    
    //MARK: - métodos init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        deleteBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        deleteBackground()
    }
    
    //Inicializo el tab bar cambiando su color de fondo asi como eliminando la imagen de sombra y la imagen background
    func deleteBackground(){
        shadowImage = UIImage()
        backgroundImage = UIImage()
        self.isTranslucent = true
        backgroundColor = UIColor.defaultBlue
        unselectedItemTintColor = UIColor.defaultDarkBlue
        selectedItem = items?.first
    }
    
   

}
