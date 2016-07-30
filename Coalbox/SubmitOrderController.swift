//
//  SubmitOrderController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 02/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class SubmitOrderController : UIViewController,UITextFieldDelegate {
    
    let orderDetails = OrderDetails()
    
    @IBOutlet weak var pickupDateLabel: UILabel!
    @IBOutlet weak var deliveryDateLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var specialTF: HoshiTextField!
    
    @IBOutlet weak var serviceType: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var service1: UISwitch!
    @IBOutlet weak var service2: UISwitch!
    
    @IBOutlet weak var s1Price: UILabel!
    @IBOutlet weak var s2Price: UILabel!
    var itemRates : [NSObject : AnyObject]?

    var tempOffset : CGFloat?
    
    var grandTotal : Int = 0
    @IBOutlet weak var grandTotalLabel: UILabel!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        scrollView.setContentOffset(CGPointMake(0, tempOffset!), animated: true)
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        tempOffset = scrollView.contentOffset.y
        scrollView.setContentOffset(CGPointMake(0, 300), animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemRates = ItemRates().getRates()
        specialTF.delegate = self
        serviceType.text = orderDetails.getDetail("serviceType") as? String
        pickupDateLabel.text = (orderDetails.getDetail("pickupDate")! as! String) + ", " + (orderDetails.getDetail("pickupSlot")! as! String)
        deliveryDateLabel.text = (orderDetails.getDetail("deliveryDate")! as! String) + ", " + (orderDetails.getDetail("deliverySlot")! as! String)
        s1Price.text = "( +Rs." + String(itemRates!["service1"] as! NSNumber) + " )"
        s2Price.text = "( +Rs." + String(itemRates!["service2"] as! NSNumber) + " )"
    }
    
    @IBAction func service1(sender: UISwitch) {
        if sender.on == true {
            grandTotal += Int(itemRates!["service1"] as! NSNumber)
        }
        else {
            grandTotal -= Int(itemRates!["service1"] as! NSNumber)
        }
        grandTotalLabel.text = "Rs." + String(grandTotal)
    }

    @IBAction func service2(sender: UISwitch) {
        if sender.on == true {
            grandTotal += Int(itemRates!["service2"] as! NSNumber)
        }
        else {
            grandTotal -= Int(itemRates!["service2"] as! NSNumber)
        }
        grandTotalLabel.text = "Rs." + String(grandTotal)
    }
    
    func setSubtotal(subtotal : Int) {
        let bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
        scrollView.setContentOffset(bottomOffset, animated: true)
        grandTotal = subtotal
        orderDetails.setDetail(subtotal, forKey: "subtotal")
        if let a = (orderDetails.getDetail("service1") as? Bool) {
            service1.on = a
            if a == true {
                grandTotal += Int(itemRates!["service1"] as! NSNumber)
            }
        }
        if let a = (orderDetails.getDetail("service2") as? Bool) {
            service2.on = a
            if a == true {
                grandTotal += Int(itemRates!["service2"] as! NSNumber)
            }
        }
        if let a = (orderDetails.getDetail("service3") as? String) {
            specialTF.text = a
        }
        subtotalLabel.text = "Rs." + String(subtotal)
        grandTotalLabel.text = "Rs." + String(grandTotal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onSubmit(sender: UIButton) {
        orderDetails.setDetail(service1.on, forKey: "service1")
        orderDetails.setDetail(service2.on, forKey: "service2")
        orderDetails.setDetail(specialTF.text, forKey: "service3")
        orderDetails.setDetail(grandTotal, forKey: "totalPrice")
        orderDetails.setDetail("Order placed", forKey: "status")
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
            sender.setTitle("", forState: .Normal)
            loading.startAnimating()
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
                self.loading.stopAnimating()
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "loginSegue" {
            let loginController = segue.destinationViewController as? ViewController
            loginController?.orderPlaced = true
        }
    }
    
}
