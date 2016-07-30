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
    var itemRates : [NSObject : AnyObject]?
    
    var subtotal : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemRates = ItemRates().getRates()
        print("items",itemRates)
        numberOfItems = getCount()
        let nib = UINib(nibName: "SummaryPageCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        itemsList.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        itemsList.delegate = self
        itemsList.dataSource = self
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
        print("here1")
        let cell : SummaryPageCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! SummaryPageCell
        let a = returnTableName(items[indexPath.row].0)
        cell.clothLabel?.text = items[indexPath.row].0
        cell.numberLabel.text =  "x" + String(items[indexPath.row].1)
        let rate = Int(itemRates![a] as! NSNumber)
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
            else if isClothName(i.0) == true {
                items.append(i)
            }
            else {
                t += 1
            }
        }
        return count - t
    }
    
    func isClothName(name : String) -> Bool {
        if name == "Single Bedsheets" || name == "Double Bedsheets" || name == "Blazers" || name == "Cotton Dhotis" || name == "Cotton Sarees" || name == "Door Curtains" || name == "Gowns" || name == "Silk Dhotis" || name == "Silk Sarees" || name == "Sofa Covers" || name == "Standard Garments" || name == "2 pc Suit" || name == "3 pc Suit" || name == "Tablecloth" || name == "Window Curtains" {
            return true
        }
        return false
    }
    
    func returnTableName(name : String) -> String {
        if name == "Single Bedsheets" {
            return "BedsheetsSingle"
        }
        else if name == "Double Bedsheets" {
            return "BedsheetsDouble"
        }
        else if name == "Cotton Dhotis" {
            return "CottonDhotis"
        }
        else if name == "Cotton Sarees" {
            return "CottonSarees"
        }
        else if name == "Silk Sarees" {
            return "SilkSarees"
        }
        else if name == "Door Curtains" {
            return "DoorCurtains"
        }
        else if name == "Silk Dhotis" {
            return "SilkDhotis"
        }
        else if name == "Sofa Covers" {
            return "SofaCovers"
        }
        else if name == "Standard Garments" {
            return "StandardGarments"
        }
        else if name == "2 pc Suit" {
            return "Suit2pc"
        }
        else if name == "3 pc Suit" {
            return "Suit3pc"
        }
        else if name == "Window Curtains" {
            return "WindowCurtains"
        }
        else {
            return name
        }
    }
}
