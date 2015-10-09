//
//  Constants.swift
//  Ting
//
//  Created by Chordia, Amisha (US - Mumbai) on 9/13/15.
//  Copyright © 2015 Chordia, Amisha (US - Mumbai). All rights reserved.
//

import Foundation

let micSize : CGFloat = 60

class Constants {

    struct touchID {
        static let kUsername : String = "username"
    }

    struct WITIntents {
        static let WITFxPosition : String = "FX_Position"
       

    }
    
    struct WITRequisites {
        static let AIToken : String = "4H4FTQZYSRHNGNT2A6XFHC7VPNLWKL3H"
        static let AIConfidence = 0.4
    }
    
    struct AIStrings {
        static let AIErrorString : String = "Sorry!  I did not get that. Please say that again!"
        static let AICurrencyErrorString : String = "Sorry! I did not clearly get the currency."
        static let AIReminderString : String = "Setting a reminder to book FX contracts for "
    }

}
