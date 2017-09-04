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
    var farm: TextElement?
    var country: TextElement?
    var variety: TextElement?
    var processing: MultipleChoiceElement?
    var altitude: TextElement?
    var price: NumberElement?

    public required init?(map: Map){
        let mapper = MapElement.init(map: map)
        
        name = mapper.map(elementName: "coffee_name", elementType: TextElement.self)
        photo = mapper.map(elementName: "photo", elementType: AssetElement.self)
        category = mapper.map(elementName: "coffee_category", elementType: TaxonomyElement.self)
        promotion = mapper.map(elementName: "promotion", elementType: MultipleChoiceElement.self)
        callToActions = mapper.map(elementName: "call_to_actions", elementType: ModularContentElement.self)
        farm = mapper.map(elementName: "farm", elementType: TextElement.self)
        country = mapper.map(elementName: "country", elementType: TextElement.self)
        variety = mapper.map(elementName: "variety", elementType: TextElement.self)
        processing = mapper.map(elementName: "processing", elementType: MultipleChoiceElement.self)
        altitude = mapper.map(elementName: "altitude", elementType: TextElement.self)
        price = mapper.map(elementName: "price", elementType: NumberElement.self)
    }
    
    public func mapping(map: Map) {

    }
}
