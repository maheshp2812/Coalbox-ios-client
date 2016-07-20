//
//  OrderCell.swift
//  Coalbox
//
//  Created by Mahesh Parab on 20/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orderIDLabel: UILabel!
    @IBOutlet weak var pickupDateLabel: UILabel!
    @IBOutlet weak var deliveryDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        priceView.layer.cornerRadius = priceView.frame.width/2
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
