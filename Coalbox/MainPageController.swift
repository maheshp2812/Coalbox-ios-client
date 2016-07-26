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
        self.navigationItem.setHidesBackButton(true, animated: false)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        optionButton.target = self
        optionButton.image = UIImage(named: "menu.png")
        optionButton.action = #selector(MainPageController.onMenuClick(_:))
        if let a = UserDetails().getDetails() {
            userdata = a
            nameLabel.text = a.valueForKey("Name") as? String
        }
        self.navigationItem.rightBarButtonItem = optionButton
        super.viewWillAppear(true)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mainPageTableSegue" {
            self.mainPageTableController = segue.destinationViewController as? MainPageTableController
        }
    }
    
    func onMenuClick(sender : UIButton!) {
        performSegueWithIdentifier("menuSegue", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
