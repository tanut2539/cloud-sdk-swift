//
//  CafeCellTableViewCell.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 16/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CafeTableViewCell: UITableViewCell {
    @IBOutlet weak var cafeTitle: UILabel!
    @IBOutlet weak var cafeSubtitle: UILabel!
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
