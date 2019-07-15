//
//  UIApplication+EXT.swift
//  NearChat
//
//  Created by Pau Enrech on 11/07/2019.
//  Copyright © 2019 Pau Enrech. All rights reserved.
//

import UIKit

extension UIApplication {
    //Esta propiedad permite acceder de forma rápida al view del status bar de la aplicación
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
