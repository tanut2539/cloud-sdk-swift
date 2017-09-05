//
//  HtmlBlock.swift
//  Pods
//
//  Created by Martin Makarsky on 05/09/2017.
//
//

import Foundation

public class HtmlBlock: Block {
    public private(set) var html: String?
    
    init(html: String?) {
        self.html = html
    }
}
