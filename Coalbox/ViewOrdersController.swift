//
//  ViewOrdersController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 20/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class ViewOrdersController : UITableViewController {
    
    let dbAccessor = DbManager(tableName: "OrderDetails")
    var ordersList : NSArray? = []
    
    let refresher = UIRefreshControl()
    
    override func viewWillAppear(animated: Bool) {
        onRefresh()
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        let nib = UINib(nibName: "OrderCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        refresher.addTarget(self, action: #selector(self.onRefresh), forControlEvents: .ValueChanged)
        super.viewDidLoad()
    }
    
    func onRefresh() {
        dbAccessor.accessOrders(["email" : UserDetails().getDetail("email") as! String], onComplete: {
            (result,response,error) in
            self.ordersList = result as? NSArray
            if error != nil {
                print(error?.description)
            }
            else if self.ordersList?.count > 0 {
                print("orderList:",self.ordersList)
            }
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        })
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(ordersList!.count)
        return ordersList!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: OrderCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! OrderCell
        cell.priceLabel.text = "Rs.30"
        cell.deliveryDateLabel.text = "Someday"
        cell.pickupDateLabel.text = "Someday"
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 152
    }
}
