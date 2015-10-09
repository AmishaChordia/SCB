//
//  AIIntentValidationClient.swift
//  Ting
//
//  Created by Chordia, Amisha (US - Mumbai) on 9/26/15.
//  Copyright © 2015 Chordia, Amisha (US - Mumbai). All rights reserved.
//

import UIKit

class AIIntentValidationClient: NSObject {
    
    
    
    func generateStringForIntent(intentObj : AIIntentModel) -> String {
        
        if intentObj.intent == Constants.WITIntents.WITFxPosition {
            return getStringWithEntitiesForFxPosition(intentObj)
        }
        return ""
    }
    
    func getStringWithEntitiesForFxPosition(intentObj : AIIntentModel) -> String {
        
        var validationStr : String = " "
        
        if let currency = intentObj.entity?.currency {
            
            if let time = intentObj.entity?.datetime {
                
                validationStr = "FX Position for \(currency) for \(time) is \(currency) 1.35m  |  SGD 1.56m"
                
            }
            validationStr = "FX Position for \(currency) is \(currency) 1.35m  |  SGD 1.56m"
        }
        AISpeechClient.readCurrentString(validationStr)
        return validationStr
    }
}