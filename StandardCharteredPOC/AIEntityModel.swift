//
//  AIEntityModel.swift
//  Ting
//
//  Created by Chordia, Amisha (US - Mumbai) on 9/26/15.
//  Copyright © 2015 Chordia, Amisha (US - Mumbai). All rights reserved.
//

import UIKit

let AICurrency = "currency"
let AITime = "datetime"
let AIEntityValue = "value"


class AIEntityModel: NSObject {
    
    var datetime : String?
    var currency : String?
    
    init(dict: NSDictionary) {
        if let currencyValues = dict.valueForKey(AICurrency) as? NSArray {
            if currencyValues.count > 0 {
                if let currencyDict = currencyValues.firstObject as? NSDictionary {
                    currency = currencyDict.valueForKey(AIEntityValue) as? String
                }
            }
            if let timeValues = dict.valueForKey(AITime) as? NSArray {
                if timeValues.count > 0 {
                    if let timeDict = timeValues.firstObject as? NSDictionary {
                        
                        if let date = timeDict.valueForKey(AIEntityValue) as? String {
                            
                            
                           datetime = date.componentsSeparatedByString("T").first
                        }
                        
                    }
                }
            }
        }
    }
}
