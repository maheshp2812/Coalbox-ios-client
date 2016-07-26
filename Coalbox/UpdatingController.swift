//
//  UpdatingController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 25/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class UpdatingController : UIViewController {
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var message: UILabel!
    
    let dbAccessor = DbManager(tableName: "ClientDetails")
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateDetails(updateEntry : [NSObject : AnyObject],details : NSDictionary) {
        dbAccessor.update(updateEntry, onComplete: {
            (result,response,error) in
            print("popping")
            if((error) != nil) {
                self.message.text = "Could not update profile"
                self.image.image = UIImage(named: "error.png")
                self.loading.stopAnimating()
            }
            else {
                self.message.text = "Profile Updated"
                self.image.image = UIImage(named: "checked.png")
                self.loading.stopAnimating()
                let newEntry = ["Name" : updateEntry["Name"] as! String!,"email":updateEntry["email"] as! String!,"password":details["password"] as! String!,"phoneNumber":updateEntry["phoneNumber"] as! String!,"address":updateEntry["address"] as! String!,"address2":updateEntry["address2"] as! String!]
                UserDetails().setDetails(newEntry)
            }
            let delay = 1 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        })
    }

}
