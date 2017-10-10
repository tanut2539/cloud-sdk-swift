//
//  MapElement.swift
//  Pods
//
//  Created by Martin Makarsky on 04/09/2017.
//
//

import ObjectMapper

public class MapElement {
    
    private var map: Map?
    
    public init(map: Map) {
        self.map = map
    }
    
    public func map<T>(elementName: String, elementType: T.Type) -> T where T: Mappable {
        let context = ElementContext(elementName: elementName)
        return Mapper<T>(context: context).map(JSON: self.map!.JSON)!
    }
    
}
