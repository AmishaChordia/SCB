//
//  AIValidationViewController.swift
//  Ting
//
//  Created by Chordia, Amisha (US - Mumbai) on 9/21/15.
//  Copyright © 2015 Chordia, Amisha (US - Mumbai). All rights reserved.
//

import UIKit
import EventKit

let leadingSpace : CGFloat = 25

class AIValidationViewController: AIBaseViewController {
    // MARK: - Properties
    
    
    @IBOutlet weak var intentRequestLabel: UILabel!
    var intentModel : AIIntentModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewLabelsAndProperties()
    }
    
    func setViewLabelsAndProperties() {
        view.backgroundColor = UIColor.whiteColor()
        let validationClient = AIIntentValidationClient()
        let intentRequestLabelString = validationClient.generateStringForIntent(intentModel)
        
        if intentRequestLabelString.characters.count > 0 {
            intentRequestLabel.text = intentRequestLabelString
        }
        else {
            returnToDashBoardView()
        }
        
    }
    
    // MARK: - Utility methods
    
    static func createValidationVCInstance() -> AIValidationViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let validationViewController : AIValidationViewController = storyboard.instantiateViewControllerWithIdentifier("AIValidationViewController") as! AIValidationViewController
        return validationViewController
    }
    
    // MARK: - IBAction methods
    
    @IBAction func userTappedTouchID(sender: UIButton) {
        AILoginManager.evaluateTouchIDAuthentication({ (success, authError) -> Void in
          
            if authError != nil {
                return
            }
            else if let isSuccess = success {
                if isSuccess {
                    dispatch_after(0, dispatch_get_main_queue(), { () -> Void in
                        self.userSetReminderSuccessfully()
                    })
                }
            }
        })
    }
    
    func setReminderInCalender() {
        let eventStore : EKEventStore = EKEventStore()
        eventStore.requestAccessToEntityType(EKEntityType.Reminder, completion: {
            granted, error in
            if (granted) && (error == nil) {
                
                let reminder:EKReminder = EKReminder(eventStore: eventStore)
                reminder.title = "FX Reminder"
                reminder.notes = self.getReminderString()
                
                let calendar : EKCalendar = EKCalendar(forEntityType: EKEntityType.Reminder, eventStore: eventStore)
                
                
                // Set the calendar title.
                calendar.title = "Standard Chartered Bank";
                calendar.CGColor = UIColor.SCBBrandBlueColor().CGColor
                calendar.source = eventStore.defaultCalendarForNewReminders().source
                do {
                   try  eventStore.saveCalendar(calendar, commit: true)
                    print("calendar saved")
                    
                    reminder.calendar = calendar
                    do {
                        try eventStore.saveReminder(reminder, commit: true)
                        print("Saved Event")
                        
                    }
                    catch {
                        print("Saved Event errorrrrr")
                    }
                    
                }
                catch {
                    print("calendar saved errorrrrr")
                }
            }
        })
    }
    
    func userSetReminderSuccessfully() {
        setReminderInCalender()
//        let currencyString = getReminderString()
        AISpeechClient.readCurrentString("Reminder Set")

//        AISpeechClient.readCurrentString(Constants.AIStrings.AIReminderString + currencyString)
    }
    
    func getReminderString() -> String {
        return (intentModel.entity?.currency)! + " and SGD"

    }
    
    @IBAction func userChangedMind(sender: UIButton) {
        returnToDashBoardView()
    }
    
    func returnToDashBoardView() {
        navigationController?.popViewControllerAnimated(true)
    }
}
