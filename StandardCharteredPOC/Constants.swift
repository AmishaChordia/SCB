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
        static let WITBlockCard : String = "block_card"
        static let WITTransferMoney : String = "transfer_money"
        static let WITBalance : String = "discrete_balance"
        static let WITChangePIN : String = "change_PIN"

    }
    
    struct WITRequisites {
        static let AIToken : String = "4H4FTQZYSRHNGNT2A6XFHC7VPNLWKL3H"
        static let AIConfidence = 0.3
    }
    
    struct AIStrings {
        static let AIErrorString : String = "Sorry!  I did not get that. Please say that again!"
        static let AIPersonErrorString : String = "Sorry! I did not get the person's name to trasfer your amount."
        static let AIMoneyErrorString : String = "Sorry! I did not get the amount of money to trasfer."


    }

}
