//
//  ItemRates.swift
//  Coalbox
//
//  Created by Mahesh Parab on 12/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import Foundation


class ItemRates {
    var rates = ["Standard Garments":5,"Door Curtains":20,"Window Curtains":10,"Tablecloth":5,"Bedsheets":7,"Sofa Covers":15,"Cotton Sarees":10,"Silk Sarees":15,"Cotton Dhotis":10,"Silk Dhotis":15,"2 pc Suit":20,"3 pc Suit":30,"Blazers":10,"Gowns":10,"Service1" : 40,"Service2":50,"Service3":40]
    
    func get(forKey : String) -> Int? {
        return rates[forKey]
    }
    
    func set(forKey: String,value : Int) {
        rates[forKey] = value
    }
    
    func getAllDetails() -> Dictionary<String,Int>{
        return rates
    }
}