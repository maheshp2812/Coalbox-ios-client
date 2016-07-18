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
    
    let label = UILabel()
    
    var parentController : MainPageController!
    
    override func viewWillAppear(animated: Bool) {
        print("processing...")
        label.frame =  CGRect(x: 159, y: 96, width: 250, height: 30)
        super.viewWillAppear(true)
    }
    
    func onRefresh() {
        parentController = self.parentViewController as! MainPageController
        self.parentController.orderIDStack.hidden = true
        self.parentController.priceView.hidden = true
        parentController?.activityIndicator.startAnimating()
        label.removeFromSuperview()
        recentOrder = []
        if UserDetails().getDetails() != nil {
            print("inside if")
            parentController?.refreshButton.setTitle("Refreshing...", forState: .Normal)
            parentController?.refreshButton.enabled = false
            dbAccessor.accessRecentOrder(["email" : UserDetails().getDetail("email") as! String], onComplete: {
                (result,response,error) in
                if result?.count > 0 {
                    print("inside nested if")
                    self.addData(result as! NSDictionary)
                    self.parentController?.orderIDStack.hidden = false
                    self.parentController?.priceView.hidden = false
                    self.parentController?.activityIndicator.stopAnimating()
                    self.view.addSubview(self.itemsList)
                    self.tableView.separatorStyle = .None
                    self.tableView.allowsSelection = false
                    print(self.recentOrder)
                }
                else {
                    print("inside nested else")
                    self.parentController?.activityIndicator.stopAnimating()
                    self.label.text = "No orders have been placed"
                    self.parentController?.scrollView.addSubview(self.label)
                }
                print("finished nested if-else")
                self.parentController?.refreshButton.setTitle("Refresh status", forState: .Normal)
                self.parentController?.refreshButton.enabled = true
            })
        }
        else {
            print("inside else")
            label.text = "You are not logged in"
            parentController?.activityIndicator.stopAnimating()
            parentController?.scrollView.addSubview(label)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        label.frame =  CGRect(x: parentController!.view.frame.width/2 - 125, y: parentController!.view.frame.height/2 - 15, width: 250, height: 30)
//        label.frame =  CGRect(x: 100, y: 50, width: 250, height: 30)
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
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        cell.textLabel!.text = recentOrder[indexPath.row].0
        cell.detailTextLabel!.text = "x " + String((recentOrder[indexPath.row].1)!)
        return cell
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
        if name == "Bedsheets" || name == "Blazers" || name == "CottonDhotis" || name == "CottonSarees" || name == "DoorCurtains" || name == "Gowns" || name == "SilkDhotis" || name == "SilkSarees" || name == "SofaCovers" || name == "StandardGarments" || name == "Suit2pc" || name == "Suit3pc" || name == "Tablecloth" || name == "WindowCurtains" {
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
        return name
    }
}
