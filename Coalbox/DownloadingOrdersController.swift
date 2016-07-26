//
//  DownloadingOrdersController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 26/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class DownloadingOrdersController : UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    let dbAccessor = DbManager(tableName: "OrderDetails")
    var ordersList : NSArray?
    var viewOrdersController : ViewOrdersController?
    
    var backtrack = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        loading.startAnimating()
        if backtrack == true {
            backtrack = false
            image.image = nil
            message.text = ""
            self.navigationController?.popViewControllerAnimated(true)
        }
        else {
            super.viewWillAppear(true)
            dbAccessor.accessOrders(["email" : UserDetails().getDetail("email") as! String], onComplete: {
                (result,response,error) in
                self.ordersList = result as? NSArray
                if error != nil {
                    self.image.image = UIImage(named: "error.png")
                    self.message.text = "Orders could not be retrieved"
                    self.loading.stopAnimating()
                    let delay = 1 * Double(NSEC_PER_SEC)
                    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                    dispatch_after(time, dispatch_get_main_queue()) {
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                }
                else {
                    self.loading.stopAnimating()
                    self.backtrack = true
                    self.performSegueWithIdentifier("viewOrdersSegue", sender: self)
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewOrdersSegue" {
            viewOrdersController = segue.destinationViewController as? ViewOrdersController
            viewOrdersController?.ordersList = self.ordersList
        }
    }
}
