//
//  DeliveryItems.swift
//  Pods
//
//  Created by Martin Makarsky on 9/23/17.
//
//

import ObjectMapper

public class DeliveryItems<T>: Mappable where T: Mappable {
    public var items: [T]?
    
    
    public required init?(map: Map){
    }
    
    public func mapping(map: Map) {
        items <- map["items"]
    }
}
