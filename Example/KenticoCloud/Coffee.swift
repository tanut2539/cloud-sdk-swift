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
//    var shortDescription: String?
//    var longDescription: String?
    var callToActions: ModularContentElement?

    public required init?(map: Map){
        let mapper = MapElement.init(map: map)
        name = mapper.map(elementName: "coffee_name", elementType: TextElement.self)
        photo = mapper.map(elementName: "photo", elementType: AssetElement.self)
        category = mapper.map(elementName: "coffee_category", elementType: TaxonomyElement.self)
        promotion = mapper.map(elementName: "promotion", elementType: MultipleChoiceElement.self)
        callToActions = mapper.map(elementName: "call_to_actions", elementType: ModularContentElement.self)
    }
    
    public func mapping(map: Map) {

    }
}
