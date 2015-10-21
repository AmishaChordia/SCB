//
//  AIIntentValidationClient.swift
//  Ting
//
//  Created by Chordia, Amisha (US - Mumbai) on 9/26/15.
//  Copyright © 2015 Chordia, Amisha (US - Mumbai). All rights reserved.
//

import UIKit

class AIIntentValidationClient: NSObject {
    
    
    
    func generateStringForIntent(intentObj : AIIntentModel, FXValue : String) -> String {
        
        if intentObj.intent == Constants.WITIntents.WITFxPosition {
            return getStringWithEntitiesForFxPosition(intentObj, FXValue: FXValue)
        }
        return ""
    }
    
    func getStringWithEntitiesForFxPosition(intentObj : AIIntentModel, FXValue : String) -> String {
    
        var validationStr : String = ""
        if let entity = intentObj.entity {
            if let currency = entity.currency {
                
                if let time = entity.datetime {
                    
                    
                    validationStr = "FX Position for \(currency) for \(getDateAsString(time)) is \(currency) \(FXValue)mn  |  SGD 1mn"
                }
                else {
                    validationStr = "FX Position for \(currency) is \(currency) \(FXValue)mn  |  SGD 1mn"
                }
            }
        }
        
        
        AISpeechClient.readCurrentString(validationStr.stringByReplacingOccurrencesOfString("mn", withString: "million"))
        return validationStr
    }
    
    
    func getDateAsString(dateStr : String) -> String{
        let array = dateStr.componentsSeparatedByString("-")
        let month = Int(array[1])
        let day = array.last!
        
        let dateFormatter = NSDateFormatter()
        let monthNameArray : NSArray = dateFormatter.standaloneMonthSymbols
        
        return "\(day) \(monthNameArray.objectAtIndex(month! - 1))"
    }
}