//
//  MyAccountController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 15/06/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class MyAccountController : UIViewController {
    var tableViewController : AccountTableController? = nil
    
    @IBAction func onLogout(sender: UIButton) {
        let alertController = UIAlertController(title: "Logout", message:"Are you sure you want to log out?", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default,handler:{
            (alertAction) -> Void in
            UserDetails().setDetails(nil)
            self.performSegueWithIdentifier("myAccountPageToMainPage", sender: self)
        }))
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default,handler:nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        super.viewWillAppear(true)
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        print("Enter my account")
        if(editing) {
            if(tableViewController != nil) {
                tableViewController?.setEditing(true, animated: true)
                super.setEditing(true, animated: true)
            }
        }
        else {
            tableViewController?.setEditing(false, animated: true)
            super.setEditing(false, animated: true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
        if segue.identifier == "embedSegue" {
            tableViewController = segue.destinationViewController as? AccountTableController
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
