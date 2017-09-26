//
//  CoffeeDescriptionCell.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 26/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CoffeeDescriptionViewCell: UITableViewCell {
    @IBOutlet weak var coffeeDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
