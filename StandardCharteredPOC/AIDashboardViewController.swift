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
    
    // MARK: - Properties
    
    var intentArray : NSArray!
    
    // Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var micInteractionView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK: - ViewSetup
    
    func setUpView() {
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
        let validationVC : AIValidationViewController = AIValidationViewController.createValidationVCInstance()
        validationVC.intentModel = intentModel
        self.navigationController?.pushViewController(validationVC, animated: true)
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