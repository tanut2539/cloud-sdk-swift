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
    var category: TaxonomyElement?
    var promotion: MultipleChoiceElement?

    public required init?(map: Map){
        let mapper = MapElement.init(map: map)
        name = mapper.map(elementName: "coffee_name", elementType: TextElement.self)
        photo = mapper.map(elementName: "photo", elementType: AssetElement.self)
        category = mapper.map(elementName: "coffee_category", elementType: TaxonomyElement.self)
        promotion = mapper.map(elementName: "promotion", elementType: MultipleChoiceElement.self)
    }
    
    public func mapping(map: Map) {

    }
}
