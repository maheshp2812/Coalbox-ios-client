//
//  UserDetails.swift
//  Coalbox
//
//  Created by Mahesh Parab on 12/06/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import Foundation

class UserDetails {
    let defaults = NSUserDefaults.standardUserDefaults()
    func setDetails(newEntry : NSDictionary?) {
        defaults.setObject(newEntry,forKey: "UserData")
    }
    
    func getDetails() -> NSDictionary? {
        let newEntry = defaults.objectForKey("UserData") as? NSDictionary
        return newEntry
    }
    
    func getDetail(forKey : String) -> AnyObject? {
        let newEntry = getDetails()
        return newEntry?[forKey]
    }
}
