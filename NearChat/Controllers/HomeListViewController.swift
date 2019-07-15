//
//  HomeListViewController.swift
//  NearChat
//
//  Created by Pau Enrech on 11/07/2019.
//  Copyright © 2019 Pau Enrech. All rights reserved.
//

import UIKit

//Esta clase implementa las funcionalidades de la lista de eventos cercanos
class HomeListViewController: UIViewController {

    //MARK: - variables
    
    weak var pageChangeDelegate: PageChangedPageControllerProtrocol? = nil
    var position: Int? = nil
    
    //MARK: - métodos vista
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.defaultLightBlue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //Se implementa y utiliza un protocolo que determina cuando la página de un determinado page controller
    //ha cambiado en función de si la vista de su controller hijo (esta instacia), ha cargado completamente
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let position = position else { return }
        pageChangeDelegate?.pageChangedTo(page: position)
    }



}
