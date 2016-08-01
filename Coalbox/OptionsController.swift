//
//  OptionsController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 26/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class OptionsController : UITableViewController {
    let userDetails = UserDetails().getDetails()
    @IBOutlet weak var accountLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        if userDetails != nil {
            accountLabel.text = "My Account"
        }
        else {
            accountLabel.text = "Login"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if userDetails != nil {
                performSegueWithIdentifier("myAccountSegue", sender: self)
            }
            else {
                performSegueWithIdentifier("loginSegue", sender: self)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "loginSegue" {
            let loginController = segue.destinationViewController as? ViewController
            loginController?.mainPageAccess = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
