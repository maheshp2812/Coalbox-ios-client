//
//  CoalboxController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 31/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class HomeController : UIViewController {
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var scrollView: UIScrollView!
    var tableController : CoalboxTableController?
    var recentOrder : [(String,AnyObject?)] = []
    
    @IBOutlet weak var balanceLabel: UILabel!
    let dbAccessor = DbManager(tableName: "OrderDetails")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(onRefresh), forControlEvents: .ValueChanged)
        scrollView.addSubview(refreshControl)
    }
    
    func onRefresh() {
        recentOrder = []
        if UserDetails().getDetails() != nil {
            dbAccessor.accessRecentOrder(["email" : UserDetails().getDetail("email") as! String], onComplete: {
                (result,response,error) in
                if result?.count > 0 {
                    let orderData = result as! NSDictionary
                    self.tableController?.totalPrice.text = String(orderData["totalPrice"] as! NSNumber)
                    self.tableController?.pickupLabel.text = (orderData["pickupDate"] as? String)! + ", " + (orderData["pickupSlot"] as? String)!
                    self.tableController?.deliveryLabel.text = (orderData["deliveryDate"] as? String)! + ", " + (orderData["deliverySlot"] as? String)!
                    let progressText = orderData["status"] as! String
                    if progressText == "Order placed" {
                        self.tableController?.currentStatus.textColor = UIColor.redColor()
                    } else if progressText == "In progress" {
                        self.tableController?.currentStatus.textColor = UIColor(red: 224/255, green: 170/255, blue: 0, alpha: 1)
                    } else {
                        self.tableController?.currentStatus.textColor = UIColor(red: 65/255, green: 117/255, blue: 5/255, alpha: 1)
                    }
                    self.tableController?.currentStatus.text = progressText
                    let serviceType = orderData["serviceType"] as! String
                    if serviceType == "Regular" {
                        self.tableController?.serviceType.textColor = UIColor(red: 252/255, green: 0/255, blue: 55/255, alpha: 1)
                    } else {
                        self.tableController?.serviceType.textColor = UIColor(red: 57/255, green: 73/255, blue: 171/255, alpha: 1)
                    }
                    
                }
                self.refreshControl.endRefreshing()
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 1, green: 87/255, blue: 34/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.blackColor()]
        UIApplication.sharedApplication().statusBarStyle = .Default
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: false)
        super.viewWillAppear(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "coalboxTableSegue" {
            tableController = segue.destinationViewController as? CoalboxTableController
        }
    }
}
