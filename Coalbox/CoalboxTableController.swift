//
//  CoalboxTableController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 01/08/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class CoalboxTableController : UITableViewController {
    
    @IBOutlet weak var orderID: UILabel!
    @IBOutlet weak var pickupLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var serviceType: UILabel!
    @IBOutlet weak var currentStatus: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
