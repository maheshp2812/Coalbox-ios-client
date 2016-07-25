//
//  MainPageTableController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 17/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class MainPageTableController : UITableViewController {
    
    let dbAccessor = DbManager(tableName: "ClientDetails")
    
    var itemsList = UITableView()
    var recentOrder : [(String,AnyObject?)] = []
    
    var parentController : MainPageController!
    
    override func viewWillAppear(animated: Bool) {
        print("processing...")
        super.viewWillAppear(true)
    }
    
    func onRefresh() {
        parentController = self.parentViewController as! MainPageController
        self.parentController.orderIDStack.hidden = true
        self.parentController.priceView.hidden = true
        itemsList.hidden = true
        parentController?.activityIndicator.startAnimating()
        parentController.infoLabel.hidden = true
        recentOrder = []
        self.tableView.hidden = true
        if UserDetails().getDetails() != nil {
            print("inside if")
            parentController?.refreshButton.setTitle("REFRESHING...", forState: .Normal)
            parentController?.refreshButton.enabled = false
            dbAccessor.accessRecentOrder(["email" : UserDetails().getDetail("email") as! String], onComplete: {
                (result,response,error) in
                print("result1",result)
                if result?.count > 0  {
                    print("inside nested if")
                    print("result",result)
                    let orderData = result as! NSDictionary
                    self.addData(orderData)
                    let number = orderData["totalPrice"] as! NSNumber
                    let dateString = ((result?.valueForKey("pickupDate"))! as! String)
                    self.parentController.priceLabel.text = "Rs.\(number)"
                    if orderData["serviceType"] as! String == "Regular" {
                        self.parentController.priceView.backgroundColor = UIColor(red: 252/255, green: 0/255, blue: 55/255, alpha: 1)
                    }
                    else {
                        self.parentController.priceView.backgroundColor = UIColor(red: 17/255, green: 121/255, blue: 245/255, alpha: 1)
                    }
                    self.parentController.pickupDateLabel.text = dateString + ", " + ((result?.valueForKey("pickupSlot"))! as! String)
                    self.parentController.orderIDLabel.text = result?.valueForKey("id") as? String
                    self.parentController?.orderIDStack.hidden = false
                    self.parentController?.priceView.hidden = false
                    self.parentController?.activityIndicator.stopAnimating()
                    self.tableView.hidden = false
                    self.view.addSubview(self.itemsList)
                    self.tableView.separatorStyle = .None
                    self.tableView.allowsSelection = false
                    print(self.recentOrder)
                }
                else {
                    print("inside nested else")
                    self.parentController?.activityIndicator.stopAnimating()
                    self.parentController.infoLabel.text = "No recent orders"
                    self.parentController.infoLabel.hidden = false
                }
                print("finished nested if-else")
                self.parentController?.refreshButton.setTitle("REFRESH", forState: .Normal)
                self.parentController?.refreshButton.enabled = true
            })
        }
        else {
            print("inside else")
            self.parentController.infoLabel.text = "You are not logged in"
            parentController?.activityIndicator.stopAnimating()
            self.parentController.infoLabel.hidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        label.frame =  CGRect(x: parentController!.view.frame.width/2 - 125, y: parentController!.view.frame.height/2 - 15, width: 250, height: 30)
//        label.frame =  CGRect(x: 100, y: 50, width: 250, height: 30)
        let nib = UINib(nibName: "MainPageCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        self.itemsList.delegate = self
        self.itemsList.dataSource = self
        self.itemsList.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentOrder.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : MainPageCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! MainPageCell
        cell.clothLabel.text = recentOrder[indexPath.row].0
        cell.numberLabel.text = "x " + String((recentOrder[indexPath.row].1)!)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    func addData(order : NSDictionary) {
        var count = 0
        for i in order {
            if isClothName(i.0 as! String) && i.1 as! NSNumber != 0 {
                recentOrder.append((returnDisplayName(i.0 as! String),i.1 as! NSNumber))
                count += 1
            }
        }
        self.tableView.reloadData()
    }
    
    func isClothName(name : String) -> Bool {
        if name == "BedsheetsSingle" || name == "BedsheetsDouble" || name == "Blazers" || name == "CottonDhotis" || name == "CottonSarees" || name == "DoorCurtains" || name == "Gowns" || name == "SilkDhotis" || name == "SilkSarees" || name == "SofaCovers" || name == "StandardGarments" || name == "Suit2pc" || name == "Suit3pc" || name == "Tablecloth" || name == "WindowCurtains" {
            return true
        }
        return false
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
        else if name == "BedsheetsSingle" {
            return "Single Bedsheets"
        }
        else if name == "BedsheetsDouble" {
            return "Double Bedsheets"
        }
        return name
    }
}
