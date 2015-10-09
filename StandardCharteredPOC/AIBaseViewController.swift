//
//  AIBaseViewController.swift
//  Ting
//
//  Created by Chordia, Amisha (US - Mumbai) on 9/13/15.
//  Copyright © 2015 Chordia, Amisha (US - Mumbai). All rights reserved.
//

import UIKit

class AIBaseViewController: UIViewController {
    @IBOutlet weak var navigatnBar: UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewProperties()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func setUpViewProperties() {
        view.backgroundColor = UIColor.SCBBrandBlueColor()
        if navigatnBar != nil {
        navigatnBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName : UIFont.tingHelveticaRegularWithSize(18)]

        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
