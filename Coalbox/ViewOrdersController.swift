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
    var orderDetails : NSDictionary? = nil
    var orderDetailsController : OrderDetailsController? = nil
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        refreshControl!.beginRefreshing()
        onRefresh()
    }
    
    override func viewDidLoad() {
        let nib = UINib(nibName: "OrderCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        refresher.addTarget(self, action: #selector(self.onRefresh), forControlEvents: .ValueChanged)
        self.refreshControl = refresher
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
            self.refreshControl!.endRefreshing()
        })
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(ordersList!.count)
        return ordersList!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: OrderCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! OrderCell
        cell.priceLabel.text = "Rs." + String(ordersList![indexPath.row].valueForKey("totalPrice") as! NSNumber)
        cell.deliveryDateLabel.text = (ordersList![indexPath.row].valueForKey("deliveryDate") as? String)! + ", " + (ordersList![indexPath.row].valueForKey("deliverySlot") as? String)!
        cell.pickupDateLabel.text = (ordersList![indexPath.row].valueForKey("pickupDate") as? String)! + ", " + (ordersList![indexPath.row].valueForKey("pickupSlot") as? String)!
        if ordersList![indexPath.row].valueForKey("serviceType") as? String == "Regular" {
            cell.priceView.backgroundColor = UIColor(red: 252/255, green: 0/255, blue: 55/255, alpha: 1)
        }
        else {
            cell.priceView.backgroundColor = UIColor(red: 17/255, green: 121/255, blue: 245/255, alpha: 1)
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        orderDetails = ordersList![indexPath.row] as? NSDictionary
        performSegueWithIdentifier("orderDetailsSegue", sender: self)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 190
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "orderDetailsSegue" {
            orderDetailsController = segue.destinationViewController as? OrderDetailsController
            orderDetailsController?.orderDetails = self.orderDetails
        }
    }
}
