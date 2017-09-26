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
        self.layer.cornerRadius = 18
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
    }
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
}
