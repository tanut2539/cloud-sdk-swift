//
//  Asset.swift
//  Pods
//
//  Created by Martin Makarsky on 04/09/2017.
//
//

import ObjectMapper

public class Asset: Mappable {
    public private(set) var name: String?
    public private(set) var type: String?
    public private(set) var size: Int?
    public private(set) var description: String?
    public private(set) var url: String?
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        name <- map["name"]
        type <- map["type"]
        size <- map["size"]
        description <- map["description"]
        url <- map["url"]
    }
}
