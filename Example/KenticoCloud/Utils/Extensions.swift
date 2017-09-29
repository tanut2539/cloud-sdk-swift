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

extension UILabel {
    func styleWithRichtextString(richtextString: String) {
        do {
            let attributedString = try NSMutableAttributedString(data: richtextString.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
            
            
            let fontSizeAttribute = [NSFontAttributeName : UIFont.systemFont(ofSize: 16.0)]
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 1.5
            let lineSpacingAttribute = [NSParagraphStyleAttributeName : paragraphStyle]
            
            attributedString.addAttributes(fontSizeAttribute, range: NSMakeRange(0, attributedString.length))
            attributedString.addAttributes(lineSpacingAttribute, range: NSMakeRange(0, attributedString.length))
            
            self.attributedText = attributedString
        } catch {
            print(error)
        }
    }
}
