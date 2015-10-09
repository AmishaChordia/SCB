//
//  AILoginManager.swift
//  Ting
//
//  Created by Chordia, Amisha (US - Mumbai) on 9/13/15.
//  Copyright © 2015 Chordia, Amisha (US - Mumbai). All rights reserved.
//

import UIKit
import LocalAuthentication

class AILoginManager: NSObject {

    static func evaluateTouchIDAuthentication(completion : ((success : Bool? , authError : NSError?) -> Void)){
        let context = LAContext()
        let authenticationString = "Please authenticate your credentials."
        
        var error : NSError? ;
        
        let touchIDEligibility : Bool = context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error)
        if touchIDEligibility {
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: authenticationString, reply: { (success, touchIDError) -> Void in
                    completion(success: success, authError: touchIDError)
                
            })
        }
    }
}
