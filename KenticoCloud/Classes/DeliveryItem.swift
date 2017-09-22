//
//  DeliveryItem.swift
//  Pods
//
//  Created by Martin Makarsky on 22/09/2017.
//
//

import ObjectMapper

open class DeliveryItem: Mappable {
    
    var map: Map
    
    public required init?(map: Map){
        self.map = map
    }
    
    open func mapping(map: Map) {
    }
    
    public func getModularContent<T>(modelType: T.Type, elementName: String) -> [T?] where T: Mappable {
        let value = map["elements.\(elementName).value"].currentValue as? String
        
        return []
    }
}
