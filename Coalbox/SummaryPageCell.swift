//
//  SummaryPageCell.swift
//  Coalbox
//
//  Created by Mahesh Parab on 23/07/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import UIKit

class SummaryPageCell: UITableViewCell {

    @IBOutlet weak var clothLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
