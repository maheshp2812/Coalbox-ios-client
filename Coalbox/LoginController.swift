//
//  LoginController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 25/05/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class LoginController : UIViewController, UITextFieldDelegate {
//    @IBOutlet weak var email: UITextField!
//    @IBOutlet weak var password: UITextField!
    let dbAccessor = DbManager(tableName: "ClientDetails")
    
    
    @IBOutlet weak var email: HoshiTextField!
    @IBOutlet weak var password: HoshiTextField!
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a n
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "login-page-background.png")!)
//        email.attributedPlaceholder = NSAttributedString(string:"Email ID",attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
//        password.attributedPlaceholder = NSAttributedString(string:"Password",attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
//        setBorder(email)
//        setBorder(password)
        email.delegate = self
        password.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        super.viewWillAppear(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = nil
        UIApplication.sharedApplication().statusBarStyle = .Default
        super.viewWillDisappear(true)
    }
    
//    func setBorder(textField : UITextField) {
//        let border = CALayer()
//        let width = CGFloat(1.0)
//        border.borderColor = UIColor.lightGrayColor().CGColor
//        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
//        border.borderWidth = width
//        textField.layer.addSublayer(border)
//        textField.layer.masksToBounds = true
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onLogin(sender: UIButton) {
        //MARK: Database functionality
        sender.backgroundColor = UIColor.greenColor()
        sender.setTitle("Logging in...", forState: UIControlState.Normal)
        var newEntry = ["email" : email.text!,"password" : password.text!]
        if(validateFields(newEntry)) {
            //MARK: SHA1 encryption
            newEntry.updateValue(password.text!.sha1(), forKey: "password")
            dbAccessor.login(newEntry, onComplete: {
                (result,response,error) -> Void in
                if(error != nil) {
                    sender.backgroundColor = UIColor(red: 17/255, green: 121/255, blue:245/255, alpha: 1.0)
                    sender.setTitle("Login", forState: UIControlState.Normal)
                    let alertController = UIAlertController(title: "Login Failed", message:error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler:nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                else if(result != nil) {
//                    print(result)
                    let resultEntry = ["Name" : result!["Name"] as! String,"email" : result!["Email"] as! String,"password" : result!["Password"] as! String,"phoneNumber":result!["phoneNumber"] as! String,"address":result!["Address1"] as! String,"address2":result!["Address2"] as! String]
                    UserDetails().setDetails(resultEntry)
                    print(self.parentViewController)
                    self.performSegueWithIdentifier("loginToMainPage", sender: self)
                    
                }
            })
        } else {
            sender.backgroundColor = UIColor(red: 17/255, green: 121/255, blue:245/255, alpha: 1.0)
            sender.setTitle("Login", forState: UIControlState.Normal)
        }
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
