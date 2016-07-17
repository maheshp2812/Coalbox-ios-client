//
//  AccountController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 31/05/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class AccountController : UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var viewOrdersButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(AccountController.onEdit))
        let details = UserDetails().getDetails()
        nameLabel.text = details!["Name"] as? String
        mailTextField.text = details!["email"] as? String
        phoneTextField.text = details!["phoneNumber"] as? String
        addressTextView.text = (details!["address"] as? String)! + "," + (details!["address2"] as? String)!
        super.viewWillAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func onLogout(sender: UIButton) {
        let alertController = UIAlertController(title: "Logout", message:"Are you sure you want to log out?", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default,handler:{
            (alertAction) -> Void in
            UserDetails().setDetails(nil)
        }))
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default,handler:nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func onEdit() {
        mailTextField.userInteractionEnabled = true
        phoneTextField.userInteractionEnabled = true
        addressTextView.userInteractionEnabled = true
        viewOrdersButton.hidden = true
        logoutButton.hidden = true
    }
}
