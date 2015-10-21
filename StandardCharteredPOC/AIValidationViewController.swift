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
let calendarTitle = "Standard Chartered Bank"
class AIValidationViewController: AIBaseViewController, micViewProtocol {
    
    // MARK: - Properties
    
    @IBOutlet weak var micView: UIView!
    @IBOutlet weak var intentRequestLabel: UILabel!
    var intentModel : AIIntentModel!
    var currency : String!
    var FXValue : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewLabelsAndProperties()
        addMicInteractionView()
    }
    
    func addMicInteractionView() {
        let witMic : AIMicInteractionView = NSBundle.mainBundle().loadNibNamed("AIMicInteractionView", owner: nil, options: nil).first as! AIMicInteractionView
        witMic.delegate = self
        witMic.frame = CGRectMake(0, 0, micView.frame.width,micView.frame.width)
        micView.addSubview(witMic)
    }
    
    func setViewLabelsAndProperties() {
        view.backgroundColor = UIColor.whiteColor()
        let validationClient = AIIntentValidationClient()
        let intentRequestLabelString = validationClient.generateStringForIntent(intentModel,FXValue: FXValue)
        
        if intentRequestLabelString.characters.count > 0 {
            intentRequestLabel.text = intentRequestLabelString
        }
        else {
            returnToDashBoardView()
        }
        
    }
    
    func askUserToNotify() {
        let notificationStr = Constants.AIStrings.AINotificationString
        AISpeechClient.readCurrentString(notificationStr)
        intentRequestLabel.text = notificationStr
        self.userSetReminderSuccessfully()

    }
    
    // MARK: - Utility methods
    
    static func createValidationVCInstance() -> AIValidationViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let validationViewController : AIValidationViewController = storyboard.instantiateViewControllerWithIdentifier("AIValidationViewController") as! AIValidationViewController
        return validationViewController
    }
    
    // MARK: - Delegate Method
    
    func userDidSelectIntent(intentModel: AIIntentModel) {
        self.intentModel = intentModel
        intentRequestLabel.text = Constants.AIStrings.AIDeficitString + currency
        let deficit = intentRequestLabel.text?.stringByReplacingOccurrencesOfString("mn", withString: "million") ?? ""
        AISpeechClient.readCurrentString(deficit)
        performSelector("askUserToNotify", withObject: nil, afterDelay: 5.0)
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
                
                let calendar : EKCalendar = self.createCalendar(eventStore)
                do {
                    try  eventStore.saveCalendar(calendar, commit: true)
                    reminder.calendar = calendar
                    do {
                        try eventStore.saveReminder(reminder, commit: true)
                    }
                    catch {
                    }
                    
                }
                catch {
                }
            }
        })
    }
    
    func createCalendar(eventStore : EKEventStore) -> EKCalendar {
        
        let calendarArray = eventStore.calendarsForEntityType(EKEntityType.Reminder)
        for calendarObj in calendarArray {
            if calendarObj.title == calendarTitle {
                return calendarObj
            }
        }
        
        let calendar : EKCalendar = EKCalendar(forEntityType: EKEntityType.Reminder, eventStore: eventStore)
        calendar.title = calendarTitle;
        calendar.CGColor = UIColor.SCBBrandBlueColor().CGColor
        calendar.source = eventStore.defaultCalendarForNewReminders().source
        return calendar
    }
    
    func userSetReminderSuccessfully() {
        setReminderInCalender()
        //        let currencyString = getReminderString()
//        AISpeechClient.readCurrentString("Reminder Set")
        
        //        AISpeechClient.readCurrentString(Constants.AIStrings.AIReminderString + currencyString)
    }
    
    func getReminderString() -> String {
        return currency + " and SGD"
        
    }
    
    @IBAction func userChangedMind(sender: UIButton) {
        returnToDashBoardView()
    }
    
    func returnToDashBoardView() {
        navigationController?.popViewControllerAnimated(true)
    }
}
