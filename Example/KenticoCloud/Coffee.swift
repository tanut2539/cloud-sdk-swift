//
//  Coffee.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 31/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import ObjectMapper

public class Coffee: Mappable {
    var name: String?
    var photoUrl: String?
    var category: String?
    var promotion: String?
    var shortDescription: String?
    var longDescription: String?
    var callToActions = [String?]()
    var farm: String?
    var country: String?
    var variety: String?
    var processing: String?
    var altitude: String?
    var price: Double?

    public required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        name <- map["elements.coffee_name.value"]
        photoUrl <- map["elements.photo.value.0.url"]
        category <- map["elements.coffee_category.value.0.name"]
        promotion <- map["elements.promotion.value.0.name"]
        shortDescription <- map["elements.short_description.value"]
        longDescription <- map["elements.long_description.value.name"]
        callToActions <- map["elements.call_to_actions.value"]
        farm <- map["elements.farm.value"]
        country <- map["elements.country.value"]
        variety <- map["elements.variety.value"]
        processing <- map["elements.processing.value.0.name"]
        altitude <- map["elements.altitude.value"]
        price <- map["elements.price.value"]

    }
}
