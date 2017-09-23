//
//  DeliveryItems.swift
//  Pods
//
//  Created by Martin Makarsky on 9/23/17.
//
//

import ObjectMapper

public class ItemsResponse<T>: Mappable where T: Mappable {
    public private(set) var deliveryItems: [DeliveryItem<T>]?
    public private(set) var items: [T]?
    private var map: Map
    
    
    public required init?(map: Map){
        self.map = map
    }
    
    public func mapping(map: Map) {
        deliveryItems <- map["items"]
        items <- map["items"]
    }
    
    public func getModularContent<T>(codename: String, type: T.Type) -> T? where T: Mappable {
        if let modularContentJson = self.map["modular_content.\(codename)"].currentValue {
            let modularContentItem = Mapper<T>().map(JSONObject: modularContentJson)
            return modularContentItem
        }
        
        return nil
    }
}
