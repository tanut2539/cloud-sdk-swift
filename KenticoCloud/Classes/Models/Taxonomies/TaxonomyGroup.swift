//
//  TaxonomyGroup.swift
//  Pods
//
//  Created by Martin Makarsky on 22/09/2017.
//
//

import ObjectMapper

public class TaxonomyGroup: Mappable {
    public private(set) var name: String?
    public private(set) var codename: String?
    public private(set) var terms: [TaxonomyTerm]?
    
    public required init?(map: Map){
    }
    
    public func mapping(map: Map) {
        name <- map["system.name"]
        codename <- map["system.codename"]
        terms <- map["terms"]
    }
}
