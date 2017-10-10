//
//  Image.swift
//  Pods
//
//  Created by Martin Makarsky on 04/09/2017.
//
//

import ObjectMapper

public class Image: Mappable {
    public private(set) var imageId: String?
    public private(set) var description: String?
    public private(set) var url: String?
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        imageId <- map["image_id"]
        description <- map["description"]
        url <- map["url"]
    }
}
