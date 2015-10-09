//
//  AIIntentModel.swift
//  Ting
//
//  Created by Chordia, Amisha (US - Mumbai) on 9/15/15.
//  Copyright © 2015 Chordia, Amisha (US - Mumbai). All rights reserved.
//

let AIIntent = "intent"
let AIEntities = "entities"
let AIConfidence = "confidence"

class AIIntentModel: NSObject {
    
    var intent : String?
    var confidence : Double?
    var entity : AIEntityModel?
    
    init(dict : NSDictionary) {
        if let userIntent : String = dict.valueForKey(AIIntent) as? String  {
            intent = userIntent
        }
        
        if let userConfidence = dict.valueForKey(AIConfidence) as? Double {
            confidence = userConfidence
        }
        
        if let userEntity : NSDictionary = dict.valueForKey(AIEntities) as? NSDictionary {
            entity = AIEntityModel(dict: userEntity)
        }
        
        print(intent,confidence,entity?.currency,entity?.datetime)
    }
}
