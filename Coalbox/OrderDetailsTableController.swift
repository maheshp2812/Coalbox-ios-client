//
//  OrderDetailsTableController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 23/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class OrderDetailsTableController : UITableViewController {
    
    var orderData : NSDictionary? = nil
    var filteredData : [(String,AnyObject)] = []
    
    var itemRates : Dictionary<String,Int> = [:]
    
    var numberOfItems = 0
    var subtotal : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(orderData)
        itemRates = ItemRates().getAllDetails()
        numberOfItems = getCount()
        let nib = UINib(nibName: "SummaryPageCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorStyle = .None
        self.tableView.allowsSelection = false
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(numberOfItems)
        return numberOfItems
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : SummaryPageCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! SummaryPageCell
        cell.clothLabel?.text = returnDisplayName(filteredData[indexPath.row].0)
        cell.numberLabel.text =  "x" + String(filteredData[indexPath.row].1)
        let rate = itemRates[returnDisplayName(filteredData[indexPath.row].0)]!
        subtotal += rate * Int(filteredData[indexPath.row].1 as! NSNumber)
        cell.costLabel!.text = "Rs." + String(rate  * Int(filteredData[indexPath.row].1 as! NSNumber))
        return cell
    }
    
    func getCount() -> Int {
        var count = orderData!.count
        var t = 0
        for i in orderData! {
            
            if i.1 as! NSObject == 0 {
                count -= 1
            }
            else if (i.0 as! String) != "deliveryDate" && (i.0 as! String) != "serviceType" && (i.0 as! String) != "pickupDate" && (i.0 as! String) != "pickupSlot" && (i.0 as! String) != "deliverySlot" && (i.0 as! String) != "service1" && (i.0 as! String) != "service2" && (i.0 as! String) != "service3" && (i.0 as! String) != "totalPrice" && (i.0 as! String) != "createdAt" && (i.0 as! String) != "deleted" && (i.0 as! String) != "id" && (i.0 as! String) != "updatedAt" && (i.0 as! String) != "version" && (i.0 as! String) != "email" {
                print(i.0 as! String)
                filteredData.append((i.0 as! String,i.1))
            }
            else {
                t += 1
            }
        }
        print(filteredData)
        return count - t
    }
    
    func returnDisplayName(name : String) -> String{
        if name == "CottonDhotis" {
            return "Cotton Dhotis"
        }
        else if name == "CottonSarees" {
            return "Cotton Sarees"
        }
        else if name == "DoorCurtains" {
            return "Door Curtains"
        }
        else if name == "SilkDhotis" {
            return "Silk Dhotis"
        }
        else if name == "SilkSarees" {
            return "Silk Sarees"
        }
        else if name == "SofaCovers" {
            return "Sofa Covers"
        }
        else if name == "StandardGarments" {
            return "Standard Garments"
        }
        else if name == "Suit2pc" {
            return "2 pc Suit"
        }
        else if name == "Suit3pc" {
            return "3 pc Suit"
        }
        else if name == "WindowCurtains" {
            return "Window Curtains"
        }
        return name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
