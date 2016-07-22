//
//  PlaceOrderContainerController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 22/06/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class PlaceOrderContainerController : UIViewController {
    var tableViewController : PlaceOrderController? = nil
    let dbManager = DbManager(tableName: "OrderDetails")
    let orderDetails = OrderDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderDetails.setDetail(Int(0), forKey: "Cotton Sarees")
        orderDetails.setDetail(Int(0), forKey: "Silk Sarees")
        orderDetails.setDetail(Int(0), forKey: "Cotton Dhotis")
        orderDetails.setDetail(Int(0), forKey: "Silk Dhotis")
        orderDetails.setDetail(Int(0), forKey: "2 pc Suit")
        orderDetails.setDetail(Int(0), forKey: "3 pc Suit")
        orderDetails.setDetail(Int(0), forKey: "Blazers")
        orderDetails.setDetail(Int(0), forKey: "Gowns")
    }
    
    override func viewWillAppear(animated: Bool) {
        if let a = orderDetails.getDetail("Standard Garments") {
            tableViewController!.StandardCount.text = String(a)
        }
        else {
//            tableViewController?.StandardCount.text = tableViewController
        }
        if let a = orderDetails.getDetail("Door Curtains") {
            tableViewController?.doorCurtainLabel.text = String(a)
        }
        if let a = orderDetails.getDetail("Window Curtains") {
            tableViewController?.windowCurtainLabel.text = String(a)
        }
        if let a = orderDetails.getDetail("Single Bedsheets") {
            tableViewController?.bedsheetLabel.text = String(a)
        }
        if let a = orderDetails.getDetail("Double Bedsheets") {
            tableViewController?.bedsheet2.text = String(a)
        }
        if let a = orderDetails.getDetail("Tablecloth") {
            tableViewController?.tableclothLabel.text = String(a)
        }
        if let a = orderDetails.getDetail("Sofa Covers") {
            tableViewController?.sofaLabel.text = String(a)
        }
        super.viewWillAppear(true)
    }
    
    @IBAction func onClick(sender: AnyObject) {
        print("inside onClick")
        let stdCount = Int((tableViewController?.StandardCount.text)!)
        let doorCurtains = Int((tableViewController?.doorCurtainLabel.text)!)
        let windowCurtains = Int((tableViewController?.windowCurtainLabel.text)!)
        let bedsheets = Int((tableViewController?.bedsheetLabel.text)!)
        let bedsheets2 = Int((tableViewController?.bedsheet2.text)!)
        let tablecloth = Int((tableViewController?.tableclothLabel.text)!)
        let sofaCovers = Int((tableViewController?.sofaLabel.text)!)
        
        if stdCount == 0 && doorCurtains == 0 && windowCurtains == 0 && bedsheets == 0 && bedsheets2 == 0 && tablecloth == 0 && sofaCovers == 0 && (tableViewController?.specialClothingController?.check == false || tableViewController?.specialClothingController?.check == nil) {
            let alertController = UIAlertController(title: "No clothes selected", message:"Please select atleast one category of clothing to proceed", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler:nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else {
            orderDetails.setDetail(stdCount, forKey: "Standard Garments")
            orderDetails.setDetail(doorCurtains, forKey: "Door Curtains")
            orderDetails.setDetail(windowCurtains, forKey: "Window Curtains")
            orderDetails.setDetail(bedsheets, forKey: "Single Bedsheets")
            orderDetails.setDetail(bedsheets2, forKey: "Double Bedsheets")
            orderDetails.setDetail(tablecloth, forKey: "Tablecloth")
            orderDetails.setDetail(sofaCovers, forKey: "Sofa Covers")
            performSegueWithIdentifier("selectServiceSegue", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embedSegue" {
            tableViewController = segue.destinationViewController as? PlaceOrderController
        }
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
}
