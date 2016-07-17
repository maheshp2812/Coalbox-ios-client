//
//  OrderDetails.swift
//  Coalbox
//
//  Created by Mahesh Parab on 28/06/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import Foundation

class OrderDetails {
    let defaults = NSUserDefaults.standardUserDefaults()
    func setAllDetails(newEntry : Dictionary<String,AnyObject>?) {
        defaults.setObject(newEntry,forKey: "OrderData")
    }
    
    func getAllDetails() -> Dictionary<String,AnyObject>? {
        let newEntry = defaults.objectForKey("OrderData") as? Dictionary<String,AnyObject>
        return newEntry
    }
    
    func setDetail(value: AnyObject?, forKey: String) {
        if var newEntry = getAllDetails() {
            newEntry[forKey] = value
            setAllDetails(newEntry)
        } else {
            setAllDetails([forKey : value!])
        }
    }
    
    func getDetail(forKey: String) -> AnyObject? {
        let newEntry = getAllDetails()
        return newEntry?[forKey]
    }
}
