//
//  AILoginViewController.swift
//  Ting
//
//  Created by Chordia, Amisha (US - Mumbai) on 9/13/15.
//  Copyright © 2015 Chordia, Amisha (US - Mumbai). All rights reserved.
//

import UIKit

let animationDuration = 0.4
let loginViewTopConstraintDefault = 205
let lessThanIP6Width = 320

class AILoginViewController: AIBaseViewController {
    
    
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let isLessThanIP6 = UIScreen.mainScreen().bounds.width <= CGFloat(lessThanIP6Width)
    
    let userKeychainWrapper = KeychainWrapper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  let savedUsername = NSUserDefaults.standardUserDefaults().valueForKey(Constants.touchID.kUsername) {
            username.text = savedUsername as? String
        }
    }
    
    func validateLoginFields() -> Bool {
        view.endEditing(true)
        if username.text?.characters.count > 0 && username.text?.characters.count > 0 {
            return true
        }
        return false
    }
    
    func pushToDashboard() {
        let dashboard = AIDashboardViewController.createDashboardVCInstance()
        navigationController?.pushViewController(dashboard, animated: true)
    }
    
    //MARK: IBAction
    
    @IBAction func loginWithTouchIdTapped(sender: UIButton) {
        if let savedUsername = NSUserDefaults.standardUserDefaults().valueForKey(Constants.touchID.kUsername) as? String{
            
            if  savedUsername == username.text {
                invokeTouchIDWithUsername(savedUsername)
            }
            else{
                loginTapped()
            }
            
        }
        else {
            loginTapped()
        }
    }
    
    func loginTapped() {
        if validateLoginFields() {
            saveUserCredentials()
            pushToDashboard()
        }
    }
    
    //MARK: TouchID Implementation
    
    func saveUserCredentials() {
        NSUserDefaults.standardUserDefaults().setValue(username.text, forKey: Constants.touchID.kUsername)
        userKeychainWrapper.mySetObject(password.text, forKey: kSecValueData)
        userKeychainWrapper.writeToKeychain()
    }
    
    func invokeTouchIDWithUsername(savedUsername : String) {
        view.endEditing(true)
        AILoginManager.evaluateTouchIDAuthentication({ (success, authError) -> Void in
            
            if authError != nil {
                return
            }
            else if (success != nil) {
                dispatch_after(0, dispatch_get_main_queue(), { () -> Void in
                    self.username.text = savedUsername as String
                    self.password.text = self.userKeychainWrapper.myObjectForKey("v_Data") as? String
                    self.pushToDashboard()
                })
            }
        })
    }
}

//MARK: UITextFieldDelegate

extension AILoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
//    func textFieldDidBeginEditing(textField: UITextField) {
//        if isLessThanIP6 {
//            if logoTopConstraint.constant == 0 {
//                self.logoTopConstraint.constant = CGFloat(-loginViewTopConstraintDefault)
//                UIView.animateWithDuration(animationDuration, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
//                    self.view.layoutIfNeeded()
//                    }) { (finished) -> Void in
//                }
//            }
//        }
//    }
//    
//    func textFieldDidEndEditing(textField: UITextField) {
//        if isLessThanIP6 {
//            if logoTopConstraint.constant < 0  {
//                self.logoTopConstraint.constant = 0
//                UIView.animateWithDuration(animationDuration, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
//                    self.view.layoutIfNeeded()
//                    }) { (finished) -> Void in
//                }
//            }
//        }
//    }
}