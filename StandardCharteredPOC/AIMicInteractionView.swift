//
//  AIMicInteractionView.swift
//  Ting
//
//  Created by Chordia, Amisha (US - Mumbai) on 9/16/15.
//  Copyright © 2015 Chordia, Amisha (US - Mumbai). All rights reserved.
//

import UIKit

class AIMicInteractionView: UIView , WitDelegate {
    
    @IBOutlet weak var micTextLabel: UILabel!
    @IBOutlet weak var micView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViewProperties()
    }
    
    func addWITMicButton() {
        let button : WITMicButton = WITMicButton(frame: CGRectMake(0, 0, micSize, micSize))
        micView.addSubview(button)
    }
    
    func setUpViewProperties() {
        Wit.sharedInstance().delegate = self
        addWITMicButton()
    }
    
    func witDidGraspIntent(outcomes: [AnyObject]!, messageId: String!, customData: AnyObject!, error e: NSError!) {
        if (e != nil) {
            errorUnderstandingIntent()
        }
        else {
            if outcomes != nil && outcomes.count > 0 {
                if let dataDict : NSDictionary = outcomes.first as? NSDictionary {
                    
                    let userIntent : AIIntentModel = AIIntentModel(dict: dataDict)
                    if userIntent.entity?.currency != nil {
                        // data is correct
                    }
                    else {
                        errorUnderstandingIntent()
                    }
                }
                else {
                   errorUnderstandingIntent()
                }
            }
            else {
                errorUnderstandingIntent()
            }
        }
    }
    
    func errorUnderstandingIntent() {
        AISpeechClient.readCurrentString(Constants.AIStrings.AIErrorString)
    }
}
