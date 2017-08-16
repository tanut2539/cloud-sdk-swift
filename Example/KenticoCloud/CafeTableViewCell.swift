//
//  CafeCellTableViewCell.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 16/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CafeTableViewCell: UITableViewCell {
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var firstRowAddress: UILabel!
    @IBOutlet weak var secondRowAddress: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
