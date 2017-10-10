//
//  DeliveryItem.swift
//  Pods
//
//  Created by Martin Makarsky on 9/23/17.
//
//

import ObjectMapper

public class DeliveryItem<T>: Mappable where T: Mappable {
    public var item: T?
    
    public required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        item <- map["item"]
    }
}
