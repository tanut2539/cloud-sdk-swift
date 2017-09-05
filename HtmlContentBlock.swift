//
//  HtmlContentBlock.swift
//  Pods
//
//  Created by Martin Makarsky on 05/09/2017.
//
//

import Foundation

public class HtmlContentBlock : Block {
    public private(set) var content: String = ""
    
    init(html: String?) {
        if let html = html {
            self.content = html
        }
    }
}
