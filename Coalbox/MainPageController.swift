//
//  MainPageController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 28/05/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class MainPageController : UIViewController {
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orderIDLabel: UILabel!
    @IBOutlet weak var pickupDateLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var refreshButton: UIButton!
    var userdata : NSDictionary? = nil
    let optionButton = UIBarButtonItem()
    let dbAccessor = DbManager(tableName: "ClientDetails")
    
    @IBOutlet weak var orderIDStack: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var mainPageTableController : MainPageTableController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onRefresh(refreshButton)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "main-page-background.png")!)
        priceView.layer.cornerRadius = priceView.frame.width/2
    }
    
    @IBAction func onRefresh(sender: UIButton) {
        mainPageTableController?.onRefresh()
    }
    
    override func viewWillAppear(animated: Bool) {
        OrderDetails().setAllDetails(nil)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "login-page-background.png"), forBarMetrics: .Default)
        self.navigationItem.setHidesBackButton(true, animated: false)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
//        let imageView = UIImageView(frame:CGRectMake(0, 0, 20, 20))
//        imageView.contentMode = .ScaleAspectFit
//        imageView.image = UIImage(named: "dark-logo.png")
//        self.navigationItem.titleView = imageView
        optionButton.target = self
        if let a = UserDetails().getDetails() {
            userdata = a
            //optionButton.setTitle("My Account", forState: UIControlState.Normal)
            //optionButton.addTarget(self, action: #selector(MainPageController.onMyAccountClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            optionButton.title = "My Account"
            optionButton.action = #selector(MainPageController.onMyAccountClick(_:))
            nameLabel.text = a.valueForKey("Name") as? String
        }
        else {
            //optionButton.setTitle("Login", forState: UIControlState.Normal)
            //optionButton.addTarget(self, action: #selector(MainPageController.onLoginClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            optionButton.title = "Login"
            optionButton.action = #selector(MainPageController.onLoginClick(_:))
        }
        self.navigationItem.rightBarButtonItem = optionButton
        super.viewWillAppear(true)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mainPageTableSegue" {
            self.mainPageTableController = segue.destinationViewController as? MainPageTableController
        }
        else if segue.identifier == "mainPageToLoginPage" {
            let loginController = segue.destinationViewController as? ViewController
            loginController?.mainPageAccess = true
        }
    }
    
    func onLoginClick(sender : UIButton!) {
        performSegueWithIdentifier("mainPageToLoginPage", sender: self)
    }
    
    func onMyAccountClick(sender : UIButton!) {
        performSegueWithIdentifier("mainPageToAccountPage", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
