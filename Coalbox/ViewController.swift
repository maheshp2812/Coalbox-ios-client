//
//  ViewController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 23/05/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "launch-login-background.png")!)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        if UserDetails().getDetails() != nil {
            performSegueWithIdentifier("launchloginToMainPage", sender: self)
        }
        super.viewWillAppear(true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

