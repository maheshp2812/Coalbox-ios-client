//
//  OrderDetailsController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 23/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class OrderDetailsController : UIViewController {
    var orderDetails : NSDictionary? = [:]
    var tableController : OrderDetailsTableController? = nil
    
    @IBOutlet weak var service1Image: UIImageView!
    @IBOutlet weak var service2Image: UIImageView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var grandTotalLabel: UILabel!
    @IBOutlet weak var specialLabel: UILabel!
    @IBOutlet weak var specialStack: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        service1Image.hidden = true
        service2Image.hidden = true
        specialStack.hidden = true
        if orderDetails?.valueForKey("service1") as! NSNumber == 1 {
            service1Image.hidden = false
        }
        if orderDetails?.valueForKey("service2") as! NSNumber == 1 {
            service2Image.hidden = false
        }
        if orderDetails?.valueForKey("service3") as! String != "" {
            specialLabel.text = orderDetails?.valueForKey("service3") as? String
            specialStack.hidden = false
        }
        
        subtotalLabel.text = "Rs." + String((orderDetails?.valueForKey("subtotal"))! as! NSNumber)
        grandTotalLabel.text = "Rs." + String((orderDetails?.valueForKey("totalPrice"))! as! NSNumber)
        super.viewWillAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "orderDetailsTableSegue" {
            tableController = segue.destinationViewController as? OrderDetailsTableController
            tableController?.orderData = orderDetails
        }
    }
}
