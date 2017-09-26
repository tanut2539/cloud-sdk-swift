//
//  Extensions.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 26/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

extension UIButton {
    
    func stylePinkButton() {
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
    }
}
