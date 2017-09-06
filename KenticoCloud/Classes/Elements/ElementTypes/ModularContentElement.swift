//
//  ModularContentElement.swift
//  Pods
//
//  Created by Martin Makarsky on 04/09/2017.
//
//

import ObjectMapper

public class ModularContentElement: Mappable {
    public private(set) var type: String?
    public private(set) var name: String?
    public private(set) var value: [String]?
    
    public required init?(map: Map){
    }
    
    public func mapping(map: Map) {
        var elementName = ""
        if let context = map.context as? Context {
            elementName = context.elementName
        }
        
        type <- map["elements.\(elementName).type"]
        name <- map["elements.\(elementName).name"]
        value <- map["elements.\(elementName).value"]
    }
}
