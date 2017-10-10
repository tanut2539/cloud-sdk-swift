//
//  TaxonomyElement.swift
//  Pods
//
//  Created by Martin Makarsky on 04/09/2017.
//
//

import ObjectMapper

public class TaxonomyElement: Mappable {
    
    public private(set) var type: String?
    public private(set) var name: String?
    public private(set) var taxonomyGroup: String?
    public private(set) var value: [Taxonomy]?
    
    public required init?(map: Map){
    }
    
    public func mapping(map: Map) {
        var elementName = ""
        if let context = map.context as? ElementContext {
            elementName = context.elementName
        }
        
        type <- map["elements.\(elementName).type"]
        name <- map["elements.\(elementName).name"]
        taxonomyGroup <- map["elements.\(elementName).taxonomy_group"]
        value <- map["elements.\(elementName).value"]
    }
    
    public func containsCodename(codename: String) -> Bool {
        if let taxonomies = value {
            if taxonomies.contains(where: { taxonomy in taxonomy.codename == codename }) {
                return true
            }
        }
        
        return false
    }
    
    public func containsName(name: String) -> Bool {
        if let taxonomies = value {
            if taxonomies.contains(where: { taxonomy in taxonomy.name == name }) {
                return true
            }
        }
        
        return false
    }
}
