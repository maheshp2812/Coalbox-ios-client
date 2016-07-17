//
//  SignupController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 26/05/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class SignupController : UIViewController,UITextFieldDelegate,UIDropDownDelegate {
    var signupTable : SignupTableController!
    var drop : UIDropDown!
    var selectedApt = ""
    
    @IBOutlet weak var switchTC: UISwitch!
    let dbAccessor = DbManager(tableName: "ClientDetails")
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "login-page-background.png")!)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToTable" {
            self.signupTable = segue.destinationViewController as! SignupTableController
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        drop.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    func dropDown(dropDown: UIDropDown, didSelectOption option: String, atIndex index: Int) {
        print(option)
        self.selectedApt = option
    }
    
    
    @IBAction func onSignUp(sender: UIButton) {
        sender.backgroundColor = UIColor.greenColor()
        sender.setTitle("Signing up...", forState: UIControlState.Normal)
        var newEntry = ["Name":signupTable.name.text!,"email":signupTable.email.text!,"password":signupTable.password.text!,"phoneNumber":signupTable.phoneNumber.text!,"address":signupTable.address.text!,"address2":signupTable.selectedApt]
        if switchTC.on == false {
            sender.backgroundColor = UIColor(red: 17/255, green: 121/255, blue:245/255, alpha: 1.0)
            sender.setTitle("Sign Up", forState: UIControlState.Normal)
            let alertController = UIAlertController(title: "Terms & Conditions", message: "Please agree to the Terms & Conditions to proceed", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler:nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else if validateFields(newEntry) {
            newEntry.updateValue(signupTable.password.text!.sha1(), forKey: "password")
            dbAccessor.verifyEmail(newEntry,onComplete: {
                (result,response,error) -> Void in
                sender.backgroundColor = UIColor(red: 17/255, green: 121/255, blue:245/255, alpha: 1.0)
                sender.setTitle("Sign Up with Coalbox", forState: UIControlState.Normal)
                if((error) != nil) {
                    let alertController = UIAlertController(title: "Signup Failed", message:error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler:nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                }else {
                    print("Sign up:",newEntry)
//                    UserDetails().setDetails(newEntry)
//                    self.performSegueWithIdentifier("signupToMainPage", sender: self)
                    let alertController = UIAlertController(title: "Verify your identity", message:"An email has been sent to your account for verification", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler:nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            })
        }
        else {
            sender.backgroundColor = UIColor(red: 17/255, green: 121/255, blue:245/255, alpha: 1.0)
            sender.setTitle("Sign Up", forState: UIControlState.Normal)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        super.viewWillAppear(true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = nil
        UIApplication.sharedApplication().statusBarStyle = .Default
        super.viewWillDisappear(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
    }
    
    func validateFields(newEntry : NSDictionary) -> Bool {
        let name = newEntry["Name"] as! String
        let email = newEntry["email"] as! String
        let password = newEntry["password"] as! String
        let phoneNo = newEntry["phoneNumber"] as! String
        let add1 = newEntry["address"] as! String
        let add2 = newEntry["address2"] as! String
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if(name.isEmpty || email.isEmpty || password.isEmpty || phoneNo.isEmpty || add1.isEmpty || add2.isEmpty || signupTable.selectedApt.isEmpty) {
            print(name.isEmpty,email.isEmpty,password.isEmpty,phoneNo.isEmpty,add1.isEmpty,add2.isEmpty,selectedApt)
            let alertController = UIAlertController(title: "Signup Failed", message:"One or more fields are empty", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler:nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return false
        }
        else if(!emailTest.evaluateWithObject(email)) {
            let alertController = UIAlertController(title: "Signup Failed", message:"Email Invalid", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler:nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return false
        }
        else if(password.characters.count < 8) {
            let alertController = UIAlertController(title: "Signup Failed", message:"Password too short", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler:nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
