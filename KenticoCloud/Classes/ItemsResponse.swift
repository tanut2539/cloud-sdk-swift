//
//  DeliveryItems.swift
//  Pods
//
//  Created by Martin Makarsky on 9/23/17.
//
//

import ObjectMapper

public class ItemsResponse<T>: Mappable where T: Mappable {
    public var deliveryItems: [DeliveryItem<T>]?
    public var items: [T]?
    
    
    public required init?(map: Map){
    }
    
    public func mapping(map: Map) {
        deliveryItems <- map["items"]
        items <- map["items"]
    }
}
