//
//  ItemRates.swift
//  Coalbox
//
//  Created by Mahesh Parab on 12/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import Foundation


class ItemRates {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    func downloadRates(onComplete : MSItemBlock) {
        DbManager(tableName: "Prices").getRates(onComplete)
    }
    
    func getRates() -> [NSObject : AnyObject]? {
        let newEntry = defaults.objectForKey("itemRates") as? [NSObject : AnyObject]
        return newEntry
    }
    
    func setRates(newEntry : [NSObject : AnyObject]) {
        defaults.setObject(newEntry,forKey: "itemRates")
    }
}