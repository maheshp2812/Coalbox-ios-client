//
//  SelectServiceController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 24/06/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class SelectServiceController : UIViewController {
    @IBOutlet weak var typeOfService: ADVSegmentedControl!
    
    @IBOutlet weak var infoLabel: UITextView!
    var pickupDate : NSDate?
    var deliveryDate : NSDate?
    var pickupContainer : PickupController?
    var deliveryContainer : DeliveryController?
    var daysForDelivery : Double = 2
    
    let orderDetail = OrderDetails()
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        typeOfService.items = ["Regular","Express"]
        typeOfService.addTarget(self, action: #selector(SelectServiceController.displayContent), forControlEvents: .ValueChanged)
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func changeDeliverySlot(value : Int) {
        if ((deliveryContainer?.defaultDate?.isEqualToDate((deliveryContainer?.selectedDate)!)) == true) && value == 1 {
            deliveryContainer?.deliverySegmentedControl.selectedSegmentIndex = 1
            deliveryContainer?.deliverySegmentedControl.setEnabled(false, forSegmentAtIndex: 0)
        }
        else {
            deliveryContainer?.deliverySegmentedControl.setEnabled(true, forSegmentAtIndex: 0)
        }
    }
    
    @IBAction func onClick(sender: UIButton) {
    }
    
    func pickupDateSelected(date : NSDate!) {
        self.pickupDate = date
        deliveryContainer?.dateButton.enabled = true
        deliveryContainer?.setDefaultDeliveryDate(self.pickupDate,days: daysForDelivery)
        changeDeliverySlot((pickupContainer?.pickupSegmentedControl.selectedSegmentIndex)!)
    }
    
    func displayContent() {
        if(typeOfService.selectedIndex == 0) {
            daysForDelivery = 2
            infoLabel.text = "Get your clothes ironed within 48 hours and delivered to your doorstep"
        } else {
            daysForDelivery = 1
            infoLabel.text = "Get your clothes ironed within 24 hours and delivered to your doorstep"
        }
        infoLabel.textAlignment = .Center
        deliveryContainer?.setDefaultDeliveryDate(self.pickupDate,days: daysForDelivery)
        changeDeliverySlot((pickupContainer?.pickupSegmentedControl.selectedSegmentIndex)!)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "serviceToPickupSegue" {
            self.pickupContainer = segue.destinationViewController as? PickupController
        } else if segue.identifier == "serviceToDeliverySegue" {
            self.deliveryContainer = segue.destinationViewController as? DeliveryController
        }
    }
    
    @IBAction func onProceed(sender: UIButton) {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        var slotString = ""
        if let a = pickupDate {
            orderDetail.setDetail(formatter.stringFromDate(a), forKey: "pickupDate")
            orderDetail.setDetail(formatter.stringFromDate(deliveryContainer!.selectedDate!), forKey: "deliveryDate")
            
            if pickupContainer!.pickupSegmentedControl.selectedSegmentIndex == 0 {
                slotString = "Morning"
            }
            else {
                slotString = "Evening"
            }
            
            orderDetail.setDetail(slotString, forKey: "pickupSlot")
            
            if deliveryContainer!.deliverySegmentedControl.selectedSegmentIndex == 0 {
                slotString = "Morning"
            }
            else {
                slotString = "Evening"
            }
            
            orderDetail.setDetail(slotString, forKey: "deliverySlot")
            if typeOfService.selectedIndex == 0 {
                orderDetail.setDetail("Regular", forKey: "serviceType")
            } else {
                orderDetail.setDetail("Express", forKey: "serviceType")
            }
            performSegueWithIdentifier("proceedSegue", sender: self)
        }
        else {
            let alertController = UIAlertController(title: "Cannot proceed", message:"Pick up date must be selected", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler:nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        infoLabel.text = "Get your clothes ironed within 48 hours and delivered to your doorstep"
        infoLabel.textAlignment = .Center
        super.viewWillAppear(true)
    }
    
    override func viewWillDisappear(animated: Bool) {
//        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
//        self.navigationController?.navigationBar.shadowImage = nil
//        self.navigationController?.navigationBar.translucent = true
//        UIApplication.sharedApplication().statusBarStyle = .Default
//        self.navigationController?.navigationBar.tintColor = UIColor.blueColor()
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        super.viewWillDisappear(true)
    }
}
