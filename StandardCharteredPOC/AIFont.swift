//
//  AIFont.swift
//  Ting
//
//  Created by Chordia, Amisha (US - Mumbai) on 9/13/15.
//  Copyright © 2015 Chordia, Amisha (US - Mumbai). All rights reserved.
//


import UIKit

extension UIFont {

    class func tingHelveticaRegularWithSize(size : CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
    class func tingHelveticaMediumWithSize(size : CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
    class func tingHelveticaBoldWithSize(size : CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
    class func tingAssetsWithSize(size : CGFloat) -> UIFont {
        return UIFont(name: "ting", size: size)!
    }

}
