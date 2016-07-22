//
//  PlaceOrderController.swift
//  Coalbox
//
//  Created by Mahesh Parab on 22/06/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class PlaceOrderController : UITableViewController {
    @IBOutlet weak var StandardCount: UILabel!
    @IBOutlet weak var doorCurtainLabel: UILabel!
    @IBOutlet weak var windowCurtainLabel: UILabel!
    @IBOutlet weak var bedsheetLabel: UILabel!
    @IBOutlet weak var bedsheet2: UILabel!
    @IBOutlet weak var tableclothLabel: UILabel!
    @IBOutlet weak var sofaLabel: UILabel!
    
    @IBOutlet weak var stepper1: UIStepper!
    @IBOutlet weak var stepper2: UIStepper!
    @IBOutlet weak var stepper3: UIStepper!
    @IBOutlet weak var stepper4: UIStepper!
    @IBOutlet weak var stepper5: UIStepper!
    @IBOutlet weak var stepper6: UIStepper!
    @IBOutlet weak var stepper7: UIStepper!
    
    var specialClothingController : SpecialClothingController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        StandardCount.text = Int(stepper1.value).description
        doorCurtainLabel.text = Int(stepper2.value).description
        windowCurtainLabel.text = Int(stepper3.value).description
        bedsheetLabel.text = Int(stepper4.value).description
        tableclothLabel.text = Int(stepper5.value).description
        sofaLabel.text = Int(stepper6.value).description
        bedsheet2.text = Int(stepper7.value).description
        
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 1, green: 87/255, blue: 34/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.blackColor()]
        self.navigationItem.setHidesBackButton(false, animated: false)
        UIApplication.sharedApplication().statusBarStyle = .Default
        print("inside place order table view")
        super.viewWillAppear(true)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }
    
    @IBAction func onValueChange(sender: UIStepper) {
        StandardCount.text = Int(sender.value).description
    }
    @IBAction func onValueChange1(sender: UIStepper) {
        doorCurtainLabel.text = Int(sender.value).description
    }
    @IBAction func onValueChange2(sender: UIStepper) {
        windowCurtainLabel.text = Int(sender.value).description
    }
    @IBAction func onValueChange3(sender: UIStepper) {
        bedsheetLabel.text = Int(sender.value).description
    }
    @IBAction func onValueChange4(sender: UIStepper) {
        tableclothLabel.text = Int(sender.value).description
    }
    @IBAction func onValueChange5(sender: UIStepper) {
        sofaLabel.text = Int(sender.value).description
    }
    @IBAction func onValueChange6(sender: UIStepper) {
        bedsheet2.text = Int(sender.value).description
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "specialClothingSegue" {
            specialClothingController = segue.destinationViewController as? SpecialClothingController
        }
    }
}
