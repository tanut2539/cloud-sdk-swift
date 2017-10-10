//
//  Image.swift
//  Pods
//
//  Created by Martin Makarsky on 04/09/2017.
//
//

import ObjectMapper

/// Represents Image.
public class Image: Mappable {
    
    /// Id of the Image.
    public private(set) var imageId: String?
    /// Description of the Image.
    public private(set) var description: String?
    /// Url of the Image.
    public private(set) var url: String?
    
    /// Maps response's json instance of the Image into strongly typed object representation.
    required public init?(map: Map) {
    }
    
    /// Maps response's json instance of the Image into strongly typed object representation.
    public func mapping(map: Map) {
        imageId <- map["image_id"]
        description <- map["description"]
        url <- map["url"]
    }
}
