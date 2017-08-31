//
//  Coffee.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 31/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import ObjectMapper


public class Coffee: Mappable {
    public var title: String?

    public required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        title <- map["elements.title.value"]
    }
}
