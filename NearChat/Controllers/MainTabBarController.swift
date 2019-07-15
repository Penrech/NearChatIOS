//
//  MainTabBarController.swift
//  NearChat
//
//  Created by Pau Enrech on 15/07/2019.
//  Copyright © 2019 Pau Enrech. All rights reserved.
//

import UIKit

//Esta clase incorpora todos los delegados necesarios para detectar todas las interacciones
//sobre el tab controller principal de la aplicación
class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    //MARK: - métodos vista
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self

    }
    
    //MARK: - métodos delegados
    
    //Este método detecta cuando se ha cambiado un controller al cambiar de tab y llama al método del page controller
    //anidado en este controller para mantener la página y la estética visual del toolbar de forma correcta ante
    //posibles cambios de tab en medio de animaciones
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let pageController = viewController.children.first as? CustomPageViewController {
            pageController.setPageAfterTabChange()
        }
    }
    
    

}
