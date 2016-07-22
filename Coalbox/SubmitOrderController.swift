//
//  SubmitOrderController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 02/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class SubmitOrderController : UIViewController {
    
    let orderDetails = OrderDetails()
    
    @IBOutlet weak var pickupDateLabel: UILabel!
    @IBOutlet weak var deliveryDateLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    
    @IBOutlet weak var service1: UISwitch!
    @IBOutlet weak var service2: UISwitch!
    @IBOutlet weak var service3: UISwitch!
    var itemRates = ItemRates()

    var summaryController : SummaryTableController? = nil
    
    var grandTotal : Int = 0
    @IBOutlet weak var grandTotalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(orderDetails.getAllDetails())
        pickupDateLabel.text = (orderDetails.getDetail("pickupDate")! as! String) + ", " + (orderDetails.getDetail("pickupSlot")! as! String)
        deliveryDateLabel.text = (orderDetails.getDetail("deliveryDate")! as! String) + ", " + (orderDetails.getDetail("deliverySlot")! as! String)
    }
    
    @IBAction func service1(sender: UISwitch) {
        if sender.on == true {
            grandTotal += itemRates.get("Service1")!
        }
        else {
            grandTotal -= itemRates.get("Service1")!
        }
        grandTotalLabel.text = "Rs." + String(grandTotal)
    }

    @IBAction func service2(sender: UISwitch) {
        if sender.on == true {
            grandTotal += itemRates.get("Service2")!
        }
        else {
            grandTotal -= itemRates.get("Service2")!
        }
        grandTotalLabel.text = "Rs." + String(grandTotal)
    }
    
    @IBAction func service3(sender: UISwitch) {
        if sender.on == true {
            grandTotal += itemRates.get("Service3")!
        }
        else {
            grandTotal -= itemRates.get("Service3")!
        }
        grandTotalLabel.text = "Rs." + String(grandTotal)
    }
    
    func setSubtotal(subtotal : Int) {
        grandTotal = subtotal
        subtotalLabel.text = "Rs." + String(subtotal)
        grandTotalLabel.text = "Rs." + String(grandTotal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onSubmit(sender: UIButton) {
        orderDetails.setDetail(service1.on, forKey: "service1")
        orderDetails.setDetail(service2.on, forKey: "service2")
        orderDetails.setDetail(service3.on, forKey: "service3")
        orderDetails.setDetail(grandTotal, forKey: "totalPrice")
        if UserDetails().getDetails() == nil {
            let alertController = UIAlertController(title: "Log In", message:"You must be logged in to place an order", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default,handler:{
                (alert : UIAlertAction!) in
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else {
            orderDetails.setDetail(UserDetails().getDetail("email"), forKey: "email")
            print(orderDetails.getAllDetails())
            sender.setTitle("Submitting...", forState: .Normal)
            sender.backgroundColor = UIColor.greenColor()
            let dbManager = DbManager(tableName: "OrderDetails")
            dbManager.placeOrder(orderDetails.getAllDetails(), onComplete: {
                (request,response,error) in
                sender.setTitle("Submit Order", forState: .Normal)
                sender.backgroundColor = UIColor(red: 17/255, green: 121/255, blue:245/255, alpha: 1.0)
                if error != nil {
                    let alertController = UIAlertController(title: "Order failed", message:"Could not place order", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler:nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                else {
                    self.performSegueWithIdentifier("submitToMainPageSegue", sender: self)
                }
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "summaryTableSegue" {
            self.summaryController = segue.destinationViewController as? SummaryTableController
        }
        else if segue.identifier == "loginSegue" {
            let loginController = segue.destinationViewController as? LoginController
            loginController?.orderPlaced = true
        }
    }
    
}
