//
//  DeliveryController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 25/06/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class DeliveryController : UIViewController,HSDatePickerViewControllerDelegate {
    @IBOutlet weak var deliverySegmentedControl: UISegmentedControl!
    @IBOutlet weak var dateButton: UIButton!
    var datePick : HSDatePickerViewController!
    var selectedDate : NSDate?
    var defaultDate : NSDate?
    var daysForDelivery : Double = 0
    override func viewDidLoad() {
        dateButton.enabled = false
        super.viewDidLoad()
    }
    
    @IBAction func onValueChange(sender: UISegmentedControl) {
//        let parentController = self.parentViewController as! SelectServiceController
//        parentController.changeDeliverySlot(deliverySegmentedControl.selectedSegmentIndex)
    }
    
    func hsDatePickerPickedDate(date: NSDate!) {
        var date1 = date
        if date.isLessThanDate(datePick.minDate) {
            date1 = datePick.minDate
        }
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        dateButton.setTitle(formatter.stringFromDate(date1), forState: .Normal)
        selectedDate = date1
        let parentController = self.parentViewController as! SelectServiceController
        parentController.changeDeliverySlot((parentController.pickupContainer?.pickupSegmentedControl.selectedSegmentIndex)!)
    }
    
    @IBAction func onClick(sender: UIButton) {
        print("test")
        datePick = HSDatePickerViewController()
        datePick.delegate = self
        if let a = defaultDate {
            datePick.date = a
            datePick.minDate = a
        }
        self.presentViewController(datePick, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setDefaultDeliveryDate(date : NSDate?,days : Double) {
        daysForDelivery = days
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        if let a = date {
            defaultDate = NSDate(timeInterval: 24*60*60*daysForDelivery, sinceDate: a)
            selectedDate = defaultDate
            dateButton.setTitle(formatter.stringFromDate(selectedDate!), forState: .Normal)
        }
    }
}
