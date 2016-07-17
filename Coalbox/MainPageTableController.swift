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
    
    override func viewWillAppear(animated: Bool) {
        print("processing...")
//        dbAccessor.accessRecentOrder(["email" : UserDetails().getDetail("email") as! String], onComplete: {
//            (result,response,error) in
//            self.addData(result as! NSDictionary)
//            self.itemsList.delegate = self
//            self.itemsList.dataSource = self
//            self.itemsList.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
//            self.view.addSubview(self.itemsList)
//            self.tableView.separatorStyle = .None
//            self.tableView.allowsSelection = false
//            print(self.recentOrder)
//            super.viewWillAppear(true)
//        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        print(cell.textLabel!.text,cell.detailTextLabel!.text)
        return cell
    }
    
    func addData(order : NSDictionary) {
        var count = 0
        for i in order {
            if isClothName(i.0 as! String) && i.1 as! NSNumber != 0 {
                recentOrder.append((i.0 as! String,i.1 as! NSNumber))
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
            
        }
        return name
    }
}
