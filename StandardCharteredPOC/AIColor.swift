//
//  AIColor.swift
//  Ting
//
//  Created by Chordia, Amisha (US - Mumbai) on 9/13/15.
//  Copyright © 2015 Chordia, Amisha (US - Mumbai). All rights reserved.
//

import UIKit

extension UIColor {
    
    class func SCBBrandBlueColor() -> UIColor {
        return UIColor(red: 22/255.0, green: 142/255.0, blue: 195/255.0, alpha: 1)
    }
    
    class func SCBDarkBlueColor() -> UIColor {
        return UIColor(red: 16/255.0, green: 118/255.0, blue: 173/255.0, alpha: 1)
    }
    
    class func tingDividerBlueColor() -> UIColor {
        return UIColor(red: 22/255.0, green: 92/255.0, blue: 131/255.0, alpha: 1)
    }
    
    
    class func tingGrayColor(opacity : CGFloat) -> UIColor {
        return UIColor(red: 49/255.0, green: 51/255.0, blue: 62/255.0, alpha: opacity)
    }
}