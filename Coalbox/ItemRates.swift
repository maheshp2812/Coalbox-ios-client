//
//  ItemRates.swift
//  Coalbox
//
//  Created by Mahesh Parab on 12/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import Foundation


class ItemRates {
    var rates : [NSObject : AnyObject]?
    
    func downloadRates(onComplete : MSItemBlock) {
        DbManager(tableName: "Prices").getRates(onComplete)
    }
    
    func getAllDetails() -> [NSObject : AnyObject]?{
        return rates
    }
}