//
//  LoadSocietiesController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 26/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class LoadSocietiesController : UIViewController {
    var signupController : SignupController?
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var aptsList : NSArray?
    let dbAccessor = DbManager(tableName: "Society")
    
    var backtrack = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "signupSegue" {
            signupController = segue.destinationViewController as? SignupController
            signupController?.aptsList = self.aptsList
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if backtrack == true {
            backtrack = false
            image.image = nil
            message.text = ""
            self.navigationController?.popViewControllerAnimated(true)
        }
        else {
            super.viewWillAppear(true)
            dbAccessor.getSocieties({
                (results,response,error) in
                if error != nil || results?.count == 0 {
                    self.image.image = UIImage(named: "error.png")
                    self.message.text = "Download failed"
                    self.loading.stopAnimating()
                    let delay = 1 * Double(NSEC_PER_SEC)
                    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                    dispatch_after(time, dispatch_get_main_queue()) {
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                }
                else {
                    self.aptsList = results as? NSArray
                    self.backtrack = true
                    self.performSegueWithIdentifier("signupSegue", sender: self)
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
