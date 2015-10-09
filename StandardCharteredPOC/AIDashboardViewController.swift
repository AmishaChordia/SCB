//
//  AIDashboardViewController.swift
//  Ting
//
//  Created by Chordia, Amisha (US - Mumbai) on 9/15/15.
//  Copyright © 2015 Chordia, Amisha (US - Mumbai). All rights reserved.
//

import UIKit
import AVFoundation

class AIDashboardViewController: AIBaseViewController {
    
    // MARK: - Properties

    var intentArray : NSArray!
    
    // Outlets
    
    @IBOutlet weak var leftBarBtn: UIBarButtonItem!
    @IBOutlet weak var rightBarBtn: UIBarButtonItem!
    @IBOutlet weak var micInteractionView: UIView!
    @IBOutlet weak var totalBalanceLabel: UILabel!
    @IBOutlet weak var lastTransactionLabel: UILabel!
    @IBOutlet weak var amountSpentMonthlyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeProperties()
        setUpView()
    }
    
    // MARK: - ViewSetup

    func initializeProperties(){
        intentArray = NSArray(objects: Constants.WITIntents.WITBlockCard, Constants.WITIntents.WITTransferMoney,  Constants.WITIntents.WITBalance, Constants.WITIntents.WITChangePIN)
        
        leftBarBtn.setTitleTextAttributes([NSFontAttributeName : UIFont.tingAssetsWithSize(25)], forState: UIControlState.Normal)
        rightBarBtn.setTitleTextAttributes([NSFontAttributeName : UIFont.tingAssetsWithSize(25)], forState: UIControlState.Normal)
    }
    
    func setUpView() {
        totalBalanceLabel.attributedText = createAmountString("₹ 2,40,000")
        lastTransactionLabel.attributedText = createAmountString("₹ 29,550")
        amountSpentMonthlyLabel.attributedText = createAmountString("₹ 45,000")
        addMicInteractionView()
    }
    
    func addMicInteractionView() {
        let micView : AIMicInteractionView = NSBundle.mainBundle().loadNibNamed("AIMicInteractionView", owner: nil, options: nil).first as! AIMicInteractionView
        micView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, micInteractionView.frame.height)
        micInteractionView.addSubview(micView)
    }
    
    // MARK: - Utility methods
    
    static func createDashboardVCInstance() -> AIDashboardViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dashboardViewController : AIDashboardViewController = storyboard.instantiateViewControllerWithIdentifier("AIDashboardViewController") as! AIDashboardViewController
        return dashboardViewController
    }
    
    func createAmountString(moneyString : String) -> NSAttributedString {
        let attributedAmount : NSMutableAttributedString = NSMutableAttributedString(string: moneyString)
        attributedAmount.addAttribute(NSFontAttributeName , value:  UIFont.tingHelveticaBoldWithSize(25.0), range: NSMakeRange(0, 1))
        return attributedAmount
    }
    
    
}