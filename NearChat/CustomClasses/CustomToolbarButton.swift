//
//  CustomToolbarButton.swift
//  NearChat
//
//  Created by Pau Enrech on 10/07/2019.
//  Copyright © 2019 Pau Enrech. All rights reserved.
//

import UIKit

//Esta clase permite guardar todos los métodos y propiedades necesarias para que los diferentes
//Botones del toolbar puedan ser animados dinámicamente
@IBDesignable class CustomToolbarButton: UIButton {

    //MARK: - variables
    
    let buttonHeight: CGFloat = 40.0
    let buttonIconHeight: CGFloat = 20.0
    let initialColor = UIColor.defaultBlue
    let secundaryColor = UIColor.white
    lazy var initialImage: UIImage = UIImage()
    var elementPrinted = false
    var rightPercentage: CGFloat? = nil
    var leftPercentage: CGFloat? = nil
    var centerPercentage: CGFloat? = nil
    var elementBackgroundColor = UIColor.defaultBlue
    var elementIconColor = UIColor.white
    var actualIcon: UIImage = UIImage()
    var visible: Visibility = .visible
    
    var boundaries: CGRect? {
        didSet{
            if let boundaries = boundaries, let screenWidth = superview?.frame.width {
                rightPercentage = 1 - (boundaries.minX / screenWidth)
                leftPercentage = 1 - (boundaries.maxX / screenWidth)
                centerPercentage = 1 - (boundaries.midX / screenWidth)
            }
        }
    }
    
    @IBInspectable var alphaValueStored: CGFloat = 1.0 {
        didSet{
            alphaValueStored = min(max(alphaValueStored, 0.0), 1.0)
        }
    }
    
    @IBInspectable var shouldChangeColor: Bool = false
    
    @IBInspectable var shouldHideOnChange: Bool = false
    
    @IBInspectable var secundaryImage: UIImage? = nil
    
    @IBInspectable var elevation: CGFloat = 2.0
    
    @IBInspectable var positionID: Int = -1
    
    //MARK: - métodos sobreescritos
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        getDefaultImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        getDefaultImage()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = false
        
        if !elementPrinted {
            setElevation(elevationAmount: elevation)
            getBoundaries()
            tintColor = secundaryColor
            elementPrinted = true
        }
        
    }
    
    //MARK: - métodos
    
    //Este método permite guardar una referencia a la imagen actual del botón que ha sido
    //insertada a través del storyboard
    func getDefaultImage(){
        initialImage = image(for: .normal) ?? UIImage()
        actualIcon = initialImage
    }
    
    //Este método permite obtener la posición exacta del botón en la pantalla
    private func getBoundaries(){
        boundaries = self.superview?.convert(self.frame, from: self.superview)
    }
    
    //Este método permite modificar la sombra que tiene el botón
    func setElevation(elevationAmount: CGFloat) {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.shadowPath = elevationAmount == 0 ? nil : shadowPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = elevationAmount 
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    }
    
    //Esta función permite cambiar de una vez todos los parámetros visuales del botón
    func applyUIChanges(){
        alpha = alphaValueStored
        setElevation(elevationAmount: elevation)
        backgroundColor = elementBackgroundColor
        tintColor = elementIconColor
        if let _ = secundaryImage {
            if image(for: .normal) != actualIcon {
                setImage(actualIcon, for: .normal)
            }
        }
        
    }
    
    
    

}
