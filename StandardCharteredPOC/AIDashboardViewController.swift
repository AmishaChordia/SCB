//
//  AIDashboardViewController.swift
//  Ting
//
//  Created by Chordia, Amisha (US - Mumbai) on 9/15/15.
//  Copyright © 2015 Chordia, Amisha (US - Mumbai). All rights reserved.
//

import UIKit
import AVFoundation

class AIDashboardViewController: AIBaseViewController , micViewProtocol{
    
    
    // Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var micInteractionView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK: - ViewSetup
    
    func setUpView() {
        edgesForExtendedLayout = .None
        addMicInteractionView()
    }
    
    func addMicInteractionView() {
        let micView : AIMicInteractionView = NSBundle.mainBundle().loadNibNamed("AIMicInteractionView", owner: nil, options: nil).first as! AIMicInteractionView
        micView.delegate = self
        micView.frame = CGRectMake(0, 0, micInteractionView.frame.width,micInteractionView.frame.width)
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
    
    //MARK : - Mic Delegate
    
    func userDidSelectIntent(intentModel : AIIntentModel) {
        
        let currency = intentModel.entity?.currency ?? "usd"
        
        getFXData(currency) { (fxCurrencyValue) -> Void in
            self.pushToValidationView(intentModel, fxPosition: fxCurrencyValue)
        }
    
    }
    
    func pushToValidationView(intentModel : AIIntentModel , fxPosition : String) {
        let validationVC : AIValidationViewController = AIValidationViewController.createValidationVCInstance()
        validationVC.intentModel = intentModel
        validationVC.FXValue = fxPosition
        validationVC.currency = intentModel.entity?.currency
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.navigationController?.pushViewController(validationVC, animated: true)
        }
    }
}

//MARK : - WebService

extension AIDashboardViewController {
    func getFXData(currencyStr : String ,   completionHandler : ((fxCurrencyValue : String) -> Void)) {
        
        Webservice.sharedInstance.getFXRates(currencyStr) { (fxValue) -> () in
           completionHandler(fxCurrencyValue: fxValue)
        }
    }
}

extension AIDashboardViewController : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.width, 2848)
    } 
}