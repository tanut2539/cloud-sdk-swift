//
//  RichTextElement.swift
//  Pods
//
//  Created by Martin Makarsky on 04/09/2017.
//
//

import ObjectMapper

public class RichTextElement: Mappable {
    public private(set) var type: String?
    public private(set) var name: String?
    public private(set) var images: [Image]?
    public private(set) var value: String?
    
    private var imageNames: [String]?
    
    public required init?(map: Map){
        // var tmp =
    }
    
    public func mapping(map: Map) {
        var elementName = ""
        if let context = map.context as? Context {
            elementName = context.elementName
        }
        
        type <- map["elements.\(elementName).type"]
        name <- map["elements.\(elementName).name"]
        imageNames <- map["elements.\(elementName).images"]
        images <- map["elements.\(elementName).images.."]
        value <- map["elements.\(elementName).value"]
    }
}

