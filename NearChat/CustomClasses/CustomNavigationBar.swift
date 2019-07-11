//
//  CustomNavigationBar.swift
//  NearChat
//
//  Created by Pau Enrech on 10/07/2019.
//  Copyright © 2019 Pau Enrech. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationBar {

    //MARK: - propiedades
    
    //Altura de la tabBar
    let tabBarHeight: CGFloat = 58.0
    
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
        backgroundColor = UIColor.defaultLightBlue
        shadowImage = UIImage()
        setBackgroundImage(UIImage(), for: .default)
    }
    
    //MARK: - método tamaño tabbar
    
    //Para mantener la estética de la app tanto en Android como en IOS he decidido que el tab bar tendrá la misma altura en ambos
    //Del mismo modo, también los iconos tendrán el mismo tamaño en ambos SO. Esta función adapta la altura del tabbar a la altura
    //Deseada, teniendo en cuenta que el tab bar en los IphoneX en adelante varia
    //Las imagenes de los iconos tiene el tamaño adecuado y están en Assets
    // Altura del tabbar = 58dp/pt altura del icono = 40dp/pt
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        
        var sizeThatFits = size
        sizeThatFits.height =  tabBarHeight
        
        return sizeThatFits
        
    }

}
