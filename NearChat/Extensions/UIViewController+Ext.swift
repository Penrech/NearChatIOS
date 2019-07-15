//
//  UIViewController+Ext.swift
//  NearChat
//
//  Created by Pau Enrech on 12/07/2019.
//  Copyright © 2019 Pau Enrech. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //Esta función es la encargada de cambiar las propiedades de los elementos del toolbar
    //En función del pager en el que se encuentran. Esta definida como extensión para que su
    //invocación sea más sencilla
    //Esta función se ejecuta cada vez que se mueve un determinado page asociado. Recibe el elemento visible
    //Actualmente y el offset del mismo.
    //Con estos dos elementos y una array de elementos del toolbar con sus respectivos parámetros inicializados previamente,
    //en su respectivo controller, puede animarse de forma genérica y tal y como el diseño de la app requiere, todos los cambios
    //de un toolbar al pasar de un controller a otro.
    //La implementación se ha diseñado a base de cálculos y prueba y error hasta conseguir un resultado sólido.
    func changeToolbarItems(percentage: CGFloat, toolbarElements: [Any]) {
        toolbarElements.forEach { (element) in
            if let textElement = element as? CustomToolbarLabel {
                if let leftSideBound = textElement.leftPercentage {
                    let textLeftPosition = (1 - leftSideBound)
                    if percentage >= textLeftPosition {
                        if textElement.visible == .invisible {
                            textElement.visible = .visible
                        }
                        textElement.alphaValueStored = (abs(textLeftPosition - percentage) * 100) / 4
                    } else {
                        textElement.alphaValueStored = 0
                        if (textElement.visible == .visible) {
                            textElement.visible = .invisible
                        }
                    }
                }
                
                //Los cambios de la UI se realizan en el hilo principal, mientras que los calculos se realizan en un hilo secundario
                DispatchQueue.main.async {
                    textElement.applyUIChanges()
                    textElement.visibility = textElement.visible
                }
            }
            if let buttonElement = element as? CustomToolbarButton {
                if let righSideBound = buttonElement.rightPercentage, let leftSideBound = buttonElement.leftPercentage, let centerSideBound = buttonElement.centerPercentage {
                    let difference = righSideBound - leftSideBound
                    
                    if (percentage > leftSideBound) {
                        let actualElevation = max(righSideBound - percentage, 0) / difference
                        let actualPositionNormalized = actualElevation * 2
                        
                        buttonElement.elevation = actualPositionNormalized
                        
                        if buttonElement.shouldChangeColor {
                            let colorBackground = buttonElement.initialColor.toColor(buttonElement.secundaryColor, percentage: (1 - actualElevation) * 100)
                            let colorIcon = buttonElement.initialColor.toColor(buttonElement.secundaryColor, percentage: actualElevation * 100)
                            
                            buttonElement.elementBackgroundColor = colorBackground
                            buttonElement.elementIconColor = colorIcon
                        }
                        
                        if buttonElement.shouldHideOnChange {
                            buttonElement.alphaValueStored = actualElevation
                        }
                        
                        if let imageSecundary = buttonElement.secundaryImage {
                            if percentage > centerSideBound {
                                buttonElement.actualIcon = imageSecundary
                            } else if percentage < centerSideBound {
                                buttonElement.actualIcon = buttonElement.initialImage
                            }
                        }
                        
                    } else {
                        if buttonElement.shouldChangeColor {
                            buttonElement.elementBackgroundColor = buttonElement.initialColor
                            buttonElement.elementIconColor = buttonElement.secundaryColor
                            
                        }
                        
                        if buttonElement.shouldHideOnChange {
                            if (percentage < righSideBound && percentage > leftSideBound) {
                                buttonElement.alphaValueStored = 0
                            } else {
                                buttonElement.alphaValueStored = 1
                            }
                        }
                        
                        buttonElement.elevation = 2
                        
                        if let _ = buttonElement.secundaryImage {
                            if buttonElement.actualIcon != buttonElement.initialImage {
                                buttonElement.actualIcon = buttonElement.initialImage
                            }
                        }
                    }
                    
                    //Los cambios de la UI se realizan en el hilo principal, mientras que los calculos se realizan en un hilo secundario
                    DispatchQueue.main.async {
                        buttonElement.applyUIChanges()
                        buttonElement.visibility = buttonElement.visible
                    }
                }
                
            }
            
        }
    }
    
    
}
