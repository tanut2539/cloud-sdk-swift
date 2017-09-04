//
//  Asset.swift
//  Pods
//
//  Created by Martin Makarsky on 04/09/2017.
//
//

import Foundation
import ObjectMapper

public class Asset: Mappable {
    public var name: String?
    public var type: String?
    public var size: Int?
    public var description: String?
    public var url: String?
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        name <- map["name"]
        type <- map["type"]
        size <- map["size"]
        description <- map["description"]
        url <- map["url"]
    }
}
