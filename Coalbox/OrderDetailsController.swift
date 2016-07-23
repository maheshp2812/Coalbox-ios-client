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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
