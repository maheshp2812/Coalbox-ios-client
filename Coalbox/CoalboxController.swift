//
//  CoalboxController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 31/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class CoalboxController : UITabBarController {
    override func viewDidLoad() {
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 1, green: 87/255, blue: 34/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.blackColor()]
        UIApplication.sharedApplication().statusBarStyle = .Default
        self.navigationItem.setHidesBackButton(true, animated: false)
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
