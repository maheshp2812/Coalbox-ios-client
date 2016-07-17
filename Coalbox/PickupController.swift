//
//  PickupController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 25/06/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class PickupController : UIViewController,HSDatePickerViewControllerDelegate {
    @IBOutlet weak var dateButton: UIButton!
    var datePick : HSDatePickerViewController!
    
    @IBOutlet weak var pickupSegmentedControl: UISegmentedControl!
    var selectedDate : NSDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onValueChange(sender: UISegmentedControl) {
        let parentController = self.parentViewController as! SelectServiceController
        parentController.changeDeliverySlot(sender.selectedSegmentIndex)
    }
    
    func hsDatePickerPickedDate(date: NSDate!) {
        var date1 = date
        if date.isLessThanDate(datePick.minDate) {
            date1 = datePick.minDate
        }
        let parentController = self.parentViewController as! SelectServiceController
        self.selectedDate = date1
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        dateButton.setTitle(formatter.stringFromDate(date1), forState: .Normal)
        parentController.pickupDateSelected(self.selectedDate)
    }
    
    @IBAction func onClick(sender: UIButton) {
        self.presentViewController(setPickupDate(), animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setPickupDate() -> HSDatePickerViewController{
        datePick = HSDatePickerViewController()
        datePick.delegate = self
        let currentDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour,.Minute], fromDate: currentDate)
        let hour = components.hour
        //MARK: Check logic here
        if hour >= 20 {
            let newDate = NSDate().dateByAddingTimeInterval(24*60*60)
            datePick.date = newDate
            datePick.minDate = newDate
        } else {
            datePick.minDate = NSDate()
        }
        return datePick
    }
}
