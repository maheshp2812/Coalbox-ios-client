//
//  ViewOrdersController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 20/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class OrderCell : UITableViewCell {
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var orderIDLabel: UILabel!
}

class ViewOrdersController : UITableViewController {
    override func viewDidLoad() {
        let newCell = OrderCell()
        self.tableView.addSubview(newCell)
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
