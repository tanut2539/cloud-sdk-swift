//
//  TaxonomyGroup.swift
//  Pods
//
//  Created by Martin Makarsky on 21/09/2017.
//
//

import ObjectMapper

public class TaxonomyGroup: Mappable {
    public private(set) var name: String?
    public private(set) var codename: String?
    public private(set) var terms: [TaxonomyGroup]?
    
    public required init?(map: Map){
    }
    
    public func mapping(map: Map) {
        name <- map["name"]
        codename <- map["codename"]
        terms <- map["terms"]
    }
}
