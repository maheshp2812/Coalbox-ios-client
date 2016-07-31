//
//  ViewController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 23/05/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var email: HoshiTextField!
    @IBOutlet weak var password: HoshiTextField!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    let dbAccessor = DbManager(tableName: "ClientDetails")
    
    var orderPlaced : Bool = false
    var mainPageAccess : Bool = false
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        email.delegate = self
        password.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 1, green: 87/255, blue: 34/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.blackColor()]
        self.navigationItem.setHidesBackButton(false, animated: false)
        UIApplication.sharedApplication().statusBarStyle = .Default
        if mainPageAccess == false  && orderPlaced == false {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
        if UserDetails().getDetails() != nil {
            performSegueWithIdentifier("launchloginToCoalboxSegue", sender: self)
        }
        super.viewWillAppear(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func forgotPassword(sender: UIBarButtonItem) {
        if let url = NSURL(string: "http://coalbox.in/passwordreset") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func onLogin(sender: UIButton) {
        sender.setTitle("", forState: .Normal)
        loading.startAnimating()
        var newEntry = ["email" : email.text!,"password" : password.text!]
        if(validateFields(newEntry)) {
            //MARK: SHA1 encryption
            newEntry.updateValue(password.text!.sha1(), forKey: "password")
            dbAccessor.login(newEntry, onComplete: {
                (result,response,error) -> Void in
                if(error != nil) {
                    self.loading.stopAnimating()
                    sender.setTitle("LOGIN", forState: .Normal)
                    let alertController = UIAlertController(title: "Login Failed", message:error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler:nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                else if(result != nil) {
                    let resultEntry = ["Name" : result!["Name"] as! String,"email" : result!["Email"] as! String,"password" : result!["Password"] as! String,"phoneNumber":result!["phoneNumber"] as! String,"address":result!["Address1"] as! String,"address2":result!["Address2"] as! String]
                    UserDetails().setDetails(resultEntry)
                    print(self.parentViewController)
                    self.loading.stopAnimating()
                    if self.orderPlaced == false {
                        self.performSegueWithIdentifier("launchloginToMainPage", sender: self)
                    }
                    else {
                        self.performSegueWithIdentifier("loginToSubmitOrderSegue", sender: self)
                    }
                    
                }
            })
        } else {
            loading.stopAnimating()
            sender.setTitle("LOGIN", forState: .Normal)
        }

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func validateFields(newEntry : NSDictionary) -> Bool{
        let email = newEntry["email"] as! String
        let password = newEntry["password"] as! String
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if(email.isEmpty || password.isEmpty) {
            let alertController = UIAlertController(title: "Login Failed", message:"One or more fields are empty", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler:nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return false
        }
        else if(!emailTest.evaluateWithObject(email)) {
            let alertController = UIAlertController(title: "Login Failed", message:"Email Invalid", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler:nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return false
        }
        return true
    }


}

