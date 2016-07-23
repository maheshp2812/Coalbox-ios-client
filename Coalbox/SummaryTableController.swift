//
//  SummaryTableController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 11/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class SummaryTableController : UITableViewController {
    
    let orderDetails = OrderDetails()
    var itemsList = UITableView()
    
    var items : [(String,AnyObject)] = []
    
    var numberOfItems = 0
    var itemRates : Dictionary<String,Int> = [:]
    
    var subtotal : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfItems = getCount()
        itemRates = ItemRates().getAllDetails()
        let nib = UINib(nibName: "SummaryPageCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        itemsList.delegate = self
        itemsList.dataSource = self
        itemsList.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(itemsList)
        self.tableView.separatorStyle = .None
        self.tableView.allowsSelection = false
    }
    
    override func viewDidAppear(animated: Bool) {
        let parentController = self.parentViewController as! SubmitOrderController
        parentController.setSubtotal(subtotal)
        super.viewDidAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : SummaryPageCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! SummaryPageCell
        cell.clothLabel?.text = items[indexPath.row].0
        cell.numberLabel.text =  "x" + String(items[indexPath.row].1)
        let rate = itemRates[items[indexPath.row].0]!
        subtotal += rate * Int(items[indexPath.row].1 as! NSNumber)
        cell.costLabel!.text = "Rs." + String(rate  * Int(items[indexPath.row].1 as! NSNumber))
        return cell
    }
    
    func getCount() -> Int {
        let orderData = orderDetails.getAllDetails()
        var count = orderData!.count
        var t = 0
        for i in orderData! {
            if i.1 as! NSObject == 0 {
                count -= 1
            }
            else if i.0 != "deliveryDate" && i.0 != "serviceType" && i.0 != "pickupDate" && i.0 != "pickupSlot" && i.0 != "deliverySlot" && i.0 != "service1" && i.0 != "service2" && i.0 != "service3" && i.0 != "totalPrice" {
                items.append(i)
            }
            else {
                t += 1
            }
        }
        return count - t
    }
}
