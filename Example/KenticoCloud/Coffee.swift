//
//  Coffee.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 31/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import ObjectMapper
import KenticoCloud

public class Coffee: Mappable {
    var name: TextElement?
    var photo: AssetElement?
    var category : TaxonomyElement?

    public required init?(map: Map){
        let mapper = MapElement.init(map: map)
        name = mapper.map(elementName: "coffee_name", elementType: TextElement.self)
        photo = mapper.map(elementName: "photo", elementType: AssetElement.self)
        category = mapper.map(elementName: "coffee_category", elementType: TaxonomyElement.self)
    }
    
    public func mapping(map: Map) {

    }
}
