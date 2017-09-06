//
//  HtmlContentBlock.swift
//  Pods
//
//  Created by Martin Makarsky on 05/09/2017.
//
//

public class HtmlContentBlock: Block {
    public private(set) var content: String?
    
    init?(html: String?) {
        
        if let tag = html {
            let emptyParagraph = "<p><br></p>"
            if tag != emptyParagraph {
                self.content = tag
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
