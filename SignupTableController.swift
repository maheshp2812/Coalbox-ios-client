//
//  SignupTableController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 09/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class SignupTableController : UITableViewController,UITextFieldDelegate,UIDropDownDelegate {
    @IBOutlet weak var phoneNumber: HoshiTextField!
    @IBOutlet weak var name: HoshiTextField!
    @IBOutlet weak var email: HoshiTextField!
    @IBOutlet weak var password: HoshiTextField!
    @IBOutlet weak var address: HoshiTextField!
    @IBOutlet weak var dropDown: UIDropDown!
    
    var selectedApt = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDown.delegate = self
        dropDown.options = ["Elita Promenade","Brigade Millennium"]
        dropDown.placeholder = "Select Apartment"
        dropDown.backgroundColor = UIColor.clearColor()
        dropDown.tintColor = UIColor.whiteColor()
        dropDown.hideOptionsWhenSelect = true
        name.delegate = self
        phoneNumber.delegate = self
        email.delegate = self
        password.delegate = self
        address.delegate = self
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dropDown.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    func dropDown(dropDown: UIDropDown, didSelectOption option: String, atIndex index: Int) {
        print(option)
        self.selectedApt = option
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
