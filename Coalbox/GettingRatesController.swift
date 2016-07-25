//
//  GettingRatesController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 25/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class GettingRatesController : UIViewController {
    var submitController : SubmitOrderController?
    var itemRates : [NSObject : AnyObject]? = nil
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        print("here2")
        super.viewDidLoad()
        ItemRates().downloadRates({
            (results,error) in
            if error != nil {
                self.image.image = UIImage(named: "error.png")
                self.message.text = "Could not get rates"
                self.loading.stopAnimating()
                let delay = 1 * Double(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue()) {
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
            else {
                ItemRates().rates = results
                self.itemRates = results
                self.performSegueWithIdentifier("proceedSegue", sender: self)
            }
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewWillAppear(true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillDisappear(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "proceedSegue" {
            submitController = segue.destinationViewController as? SubmitOrderController
            submitController?.itemRates = self.itemRates
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
