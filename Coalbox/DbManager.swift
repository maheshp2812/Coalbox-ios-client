//
//  DbManager.swift
//  Coalbox
//
//  Created by Mahesh Parab on 03/06/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import Foundation

class DbManager {
    
    let client : MSClient!
    let table : MSTable!
    
    init(tableName:String) {
        client = MSClient(applicationURLString: "https://coalbox-web.azurewebsites.net")
        table = client.tableWithName(tableName)
    }
    
    func signUp(newEntry:[NSObject : AnyObject],onComplete:MSAPIBlock) {
        client.invokeAPI("SignupController", body: newEntry, HTTPMethod: "POST", parameters: nil, headers: nil,completion: onComplete)
    }
    
    func login(newEntry:[NSObject : AnyObject],onComplete:MSAPIBlock) {
        client.invokeAPI("LoginController", body: newEntry, HTTPMethod: "POST", parameters: nil, headers: nil, completion: onComplete)
    }
    
    func update(newEntry:[NSObject : AnyObject],onComplete:MSAPIBlock) {
        client.invokeAPI("UpdateController", body: newEntry, HTTPMethod: "POST", parameters: nil, headers: nil, completion: onComplete)
    }
    
    func placeOrder(newEntry : AnyObject?, onComplete:MSAPIBlock) {
        client.invokeAPI("OrderController", body: newEntry, HTTPMethod: "POST", parameters: nil, headers: nil, completion: onComplete)
    }
    
    func accessRecentOrder(newEntry : AnyObject?,onComplete: MSAPIBlock) {
        client.invokeAPI("ReturnRecentOrder", body: newEntry, HTTPMethod: "POST", parameters: nil, headers: nil, completion: onComplete)
    }
    
    func accessOrders(newEntry : AnyObject?,onComplete: MSAPIBlock) {
        client.invokeAPI("ReturnOrders", body: newEntry, HTTPMethod: "POST", parameters: nil, headers: nil, completion: onComplete)
    }
    
    func verifyEmail(newEntry: AnyObject?,onComplete : MSAPIBlock) {
        client.invokeAPI("EmailVerification", body: newEntry, HTTPMethod: "POST", parameters: nil, headers: nil, completion: onComplete)
    }
    
    func getRates(onComplete: MSItemBlock) {
        table.readWithId("CA7B6DBB-84E6-45A3-B3FD-3CC340EB0B5A", completion: onComplete)
    }
}
