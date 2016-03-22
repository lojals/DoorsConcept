//
//  UIColorExtension.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/18/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import Foundation
import UIKit


extension UIColor{
    
    /**
     Color that will be use as theme in the whole app
     
     - returns: UIColor Light Green
     */
    class func DCThemeColorMain() -> UIColor {
        return UIColor.emerlandColor()
    }
    
    /**
     Dark Color that will be use as theme in the whole app
     
     - returns: UIColor Dark Green
     */
    class func DCThemeColorDarkMain() -> UIColor {
        return UIColor.nephritisColor()
    }
    
    /**
     Contrast Color that will be use as theme in the whole app
     
     - returns: UIColor Dark Gray
     */
    class func DCThemeColorContrastMain() -> UIColor {
        return UIColor(red:0.18, green:0.18, blue:0.18, alpha:1)
    }    
}