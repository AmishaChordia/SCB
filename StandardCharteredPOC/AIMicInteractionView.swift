//
//  AIMicInteractionView.swift
//  Ting
//
//  Created by Chordia, Amisha (US - Mumbai) on 9/16/15.
//  Copyright © 2015 Chordia, Amisha (US - Mumbai). All rights reserved.
//

import UIKit

protocol micViewProtocol {
    func userDidSelectIntent(intentModel : AIIntentModel)
}

class AIMicInteractionView: UIView , WitDelegate {
    
    @IBOutlet weak var micView: UIView!
    var delegate : micViewProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViewProperties()
    }
    
    func addWITMicButton() {
        let button : WITMicButton = WITMicButton(frame: CGRectMake(frame.width/2 - micSize/2, frame.height/2 - micSize/2, micSize, micSize))
        micView.addSubview(button)
    }
    
    func setUpViewProperties() {
        layer.cornerRadius = frame.width/2
        Wit.sharedInstance().delegate = self
        addWITMicButton()
    }
    
    func witDidGraspIntent(outcomes: [AnyObject]!, messageId: String!, customData: AnyObject!, error e: NSError!) {
        if (e != nil) {
            errorUnderstandingIntent(Constants.AIStrings.AIErrorString)
        }
        else {
            if outcomes != nil && outcomes.count > 0 {
                if let dataDict : NSDictionary = outcomes.first as? NSDictionary {
                    
                    let userIntent : AIIntentModel = AIIntentModel(dict: dataDict)
                    
                    if userIntent.intent == Constants.WITIntents.WITFxDeficit {
                        self.delegate?.userDidSelectIntent(userIntent)
                    }
                    else if userIntent.intent == Constants.WITIntents.WITFxPosition {
                        if userIntent.entity?.currency != nil {
                            // data is correct
                            self.delegate?.userDidSelectIntent(userIntent)
                        }
                        else {
                            errorUnderstandingIntent(Constants.AIStrings.AICurrencyErrorString)
                        }
                    }
                    else {
                        errorUnderstandingIntent(Constants.AIStrings.AICurrencyErrorString)
                    }
                }
                else {
                    errorUnderstandingIntent(Constants.AIStrings.AIErrorString)
                }
            }
            else {
                errorUnderstandingIntent(Constants.AIStrings.AIErrorString)
            }
        }
    }
    
    func errorUnderstandingIntent(string : String) {
        AISpeechClient.readCurrentString(string)
    }
}
