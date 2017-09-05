//
//  RichTextElement.swift
//  Pods
//
//  Created by Martin Makarsky on 04/09/2017.
//
//

import ObjectMapper

public class RichTextElement: Mappable {
    private var elementName: String = ""
    
    public private(set) var type: String?
    public private(set) var name: String?
    public private(set) var images: [Image]?
    public private(set) var value: String?
    
    private var imageNames: [String]?
    
    public required init?(map: Map){
        if let context = map.context as? Context {
            elementName = context.elementName
        }
        
        let value = map.JSON
        print(value)
//        for link in doc.xpath("//a | //link") {
//            print(link.text)
//            print(link["href"])
//        }
    }
    
    public func mapping(map: Map) {
        
        type <- map["elements.\(elementName).type"]
        name <- map["elements.\(elementName).name"]
        imageNames <- map["elements.\(elementName).images"]
        images <- map["elements.\(elementName).images.."]
        // value <- map["elements.\(elementName).value"]
    }
}

