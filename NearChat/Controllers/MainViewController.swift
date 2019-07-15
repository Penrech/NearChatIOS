//
//  MainViewController.swift
//  NearChat
//
//  Created by Pau Enrech on 05/07/2019.
//  Copyright © 2019 Pau Enrech. All rights reserved.
//

import UIKit

class MainViewController: UIViewController , ScrollFromPageChange {
    
    //MARK: - variables
    
    @IBOutlet weak var myPositionButton: CustomToolbarButton!
    
    private var toolbarElements: [Any] = []
    
    @IBAction func changeBetweenPages(_ sender: Any) {
        if let pageController = self.children.first as? CustomPageViewController {
            pageController.changePageTo()
        }
    }
    
    //MARK: - métodos vista
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpToolbar()
        
    }
    
    //MARK: - métodos
    
    //Esta función añade automáticamente una referencia a los elementos custom del toolbar a
    //una array para ser usados luego para las diversas animaciones o acciones
    //Inicializa también el delegado que permite conocer la posición del pager asociado a este controlador
    //para realizar asi la animación dinámica del toolbar
    func setUpToolbar(){
        
        view.subviews.forEach { (view) in
            if view is CustomToolbarButton || view is CustomToolbarLabel {
                toolbarElements.append(view)
            }
        }
        
        if let pageController = self.children.first as? CustomPageViewController {
            pageController.scrollViewDelegate = self
        }
    }
    
    //Este método del delegado recibe los cambios en el scroll del page controller anidado en este controller y llama
    //al método determinado en una extensión de UIViewController para cambiar dinámicamente las propiedades de los
    //diferentes elementos del toolbar
    func scrollChangeToPercentage(percentage: CGFloat) {
        changeToolbarItems(percentage: percentage, toolbarElements: toolbarElements)
    }
    

}
