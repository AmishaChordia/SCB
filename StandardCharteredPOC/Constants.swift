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
        static let WITFxDeficit : String = "FX_Deficit"

    }
    
    struct WITRequisites {
        static let AIToken : String = "4H4FTQZYSRHNGNT2A6XFHC7VPNLWKL3H"
        static let AIConfidence = 0.4
    }
    
    struct AIStrings {
        static let AINetworkErrorString : String = "Sorry!  Please be on Deloitte network to view your FX position!"

        static let AIErrorString : String = "Sorry!  I did not get that. Please say that again!"
        static let AICurrencyErrorString : String = "Sorry! I did not clearly get the currency."
        static let AIReminderString : String = "Setting a reminder to book forex contracts for "
        static let AIDeficitString : String = "You need FX worth 0.5mn "
        static let AINotificationString : String = "Do you want to set a reminder to book FX Contracts?"
        

    }

}
