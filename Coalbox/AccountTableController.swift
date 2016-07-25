//
//  AccountTableController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 15/06/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class AccountTableController : UITableViewController,UITextFieldDelegate,UIDropDownDelegate {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var emailTF: HoshiTextField!
    @IBOutlet weak var phoneTF: HoshiTextField!
    @IBOutlet weak var addressTV: HoshiTextField!
    @IBOutlet weak var dropDown: UIDropDown!
    @IBOutlet weak var aptLabel: UILabel!
    
    let aptList = ["Elita Promenade","Brigade Millennium"]
    var selectedApt = ""
    
    var updateEntry = [:]
    
    
    var details = UserDetails().getDetails()!
    let dbAccessor = DbManager(tableName: "ClientDetails")
    var updatingController : UpdatingController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.delegate = self
        emailTF.delegate = self
        phoneTF.delegate = self
        addressTV.delegate = self
        dropDown.delegate = self
        dropDown.options = NSMutableArray(array: aptList)
        dropDown.selectedIndex = returnSelectedIndex()
        dropDown.placeholder = selectedApt
    }
    
    func returnSelectedIndex() -> Int {
        let aptName = (details["address2"] as? String)!
        for i in 0 ..< aptList.count {
            if aptName == aptList[i] {
                self.selectedApt = aptName
                return i
            }
        }
        return -1
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dropDown.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    func dropDown(dropDown: UIDropDown, didSelectOption option: String, atIndex index: Int) {
        self.selectedApt = option
    }
    
    func dropDownTableWillAppear(dropDown: UIDropDown) {
        aptLabel.textColor = UIColor(red: 1, green: 87/255, blue: 34/255, alpha: 1)
    }
    
    func dropDownTableWillDisappear(dropDown: UIDropDown) {
        aptLabel.textColor = UIColor.blackColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        print("in view appear")
        details = UserDetails().getDetails()!
        nameLabel.text = details["Name"] as? String
        emailTF.text = details["email"] as? String
        phoneTF.text = details["phoneNumber"] as? String
        addressTV.text = (details["address"] as? String)!
//        address2TV.text = (details!["address2"] as? String)!
        
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 1, green: 87/255, blue: 34/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.blackColor()]
        self.navigationItem.setHidesBackButton(false, animated: false)
        UIApplication.sharedApplication().statusBarStyle = .Default
        
        super.viewWillAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField != nameLabel {
            let textF = textField as! HoshiTextField
            textF.placeholderColor = UIColor(red: 1, green: 87/255, blue: 34/255, alpha: 1)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if nameLabel != textField {
            let textF = textField as! HoshiTextField
            textF.placeholderColor = UIColor.blackColor()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        print("Enter account table")
        if(editing) {
            nameLabel.userInteractionEnabled = true
            emailTF.userInteractionEnabled = true
            phoneTF.userInteractionEnabled = true
            addressTV.userInteractionEnabled = true
            dropDown.userInteractionEnabled = true
            nameLabel.becomeFirstResponder()
        }
        else {
            nameLabel.userInteractionEnabled = false
            emailTF.userInteractionEnabled = false
            phoneTF.userInteractionEnabled = false
            addressTV.userInteractionEnabled = false
            dropDown.userInteractionEnabled = false
            aptLabel.textColor = UIColor.blackColor()
            updateEntry = ["Name" : nameLabel.text!,"email" : emailTF.text!,"phoneNumber" : phoneTF.text!,"address" : addressTV.text!,"address2" : selectedApt,"emailOld" : details["email"] as! String]
            if validateFields(updateEntry) {
//                self.view.userInteractionEnabled = false
//                self.navigationController?.navigationBar.userInteractionEnabled = false
                performSegueWithIdentifier("updatingSegue", sender: self)
                //UserDetails().setDetails(updateEntry)
            }
        }
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "updatingSegue" {
            updatingController = segue.destinationViewController as? UpdatingController
            updatingController!.updateDetails(updateEntry as [NSObject : AnyObject],details: details)
        }
    }
    
    func validateFields(newEntry : NSDictionary) -> Bool {
        let email = newEntry["email"] as! String
        let phoneNo = newEntry["phoneNumber"] as! String
        let add1 = newEntry["address"] as! String
        let add2 = newEntry["address2"] as! String
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if(nameLabel == "" || email.isEmpty || phoneNo.isEmpty || add1.isEmpty || add2.isEmpty) {
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
        return true
    }
}
