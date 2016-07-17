//
//  SpecialClothingController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 27/06/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class SpecialClothingController : UITableViewController {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var label8: UILabel!
    
    @IBOutlet weak var stepper1: UIStepper!
    @IBOutlet weak var stepper2: UIStepper!
    @IBOutlet weak var stepper3: UIStepper!
    @IBOutlet weak var stepper4: UIStepper!
    @IBOutlet weak var stepper5: UIStepper!
    @IBOutlet weak var stepper6: UIStepper!
    @IBOutlet weak var stepper7: UIStepper!
    @IBOutlet weak var stepper8: UIStepper!
    
    let orderDetails = OrderDetails()
    
    var check = false
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(self.onDoneClick))
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        //print(orderDetails.getAllDetails())
        if let a = orderDetails.getDetail("Cotton Sarees") {
            label1.text = String(a)
            stepper1.value = Double(a as! NSNumber)
        }
        if let a = orderDetails.getDetail("Silk Sarees") {
            label2.text = String(a)
            stepper2.value = Double(a as! NSNumber)
        }
        if let a = orderDetails.getDetail("Cotton Dhotis") {
            label3.text = String(a)
            stepper3.value = Double(a as! NSNumber)
        }
        if let a = orderDetails.getDetail("Silk Dhotis") {
            label4.text = String(a)
            stepper4.value = Double(a as! NSNumber)
        }
        if let a = orderDetails.getDetail("2 pc Suit") {
            label5.text = String(a)
            stepper5.value = Double(a as! NSNumber)
        }
        if let a = orderDetails.getDetail("3 pc Suit") {
            label6.text = String(a)
            stepper6.value = Double(a as! NSNumber)
        }
        if let a = orderDetails.getDetail("Blazers") {
            label7.text = String(a)
            stepper7.value = Double(a as! NSNumber)
        }
        if let a = orderDetails.getDetail("Gowns") {
            label8.text = String(a)
            stepper8.value = Double(a as! NSNumber)
        }
        super.viewWillAppear(true)
    }
    
    func onDoneClick() {
        if label1.text! != "0" || label2.text! != "0" || label3.text! != "0" || label4.text! != "0" || label5.text! != "0" || label6.text! != "0" || label7.text! != "0" || label8.text! != "0" {
            check = true
        }
        
        orderDetails.setDetail(Int(label1.text!), forKey: "Cotton Sarees")
        orderDetails.setDetail(Int(label2.text!), forKey: "Silk Sarees")
        orderDetails.setDetail(Int(label3.text!), forKey: "Cotton Dhotis")
        orderDetails.setDetail(Int(label4.text!), forKey: "Silk Dhotis")
        orderDetails.setDetail(Int(label5.text!), forKey: "2 pc Suit")
        orderDetails.setDetail(Int(label6.text!), forKey: "3 pc Suit")
        orderDetails.setDetail(Int(label7.text!), forKey: "Blazers")
        orderDetails.setDetail(Int(label8.text!), forKey: "Gowns")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onClickStepper1(sender: UIStepper) {
        label1.text = Int(sender.value).description
    }
    @IBAction func onClickStepper2(sender: UIStepper) {
        label2.text = Int(sender.value).description
    }
    @IBAction func onClickStepper3(sender: UIStepper) {
        label3.text = Int(sender.value).description
    }
    @IBAction func onClickStepper4(sender: UIStepper) {
        label4.text = Int(sender.value).description
    }
    @IBAction func onClickStepper5(sender: UIStepper) {
        label5.text = Int(sender.value).description
    }
    @IBAction func onClickStepper6(sender: UIStepper) {
        label6.text = Int(sender.value).description
    }
    @IBAction func onClickStepper7(sender: UIStepper) {
        label7.text = Int(sender.value).description
    }
    @IBAction func onClickStepper8(sender: UIStepper) {
        label8.text = Int(sender.value).description
    }
}
