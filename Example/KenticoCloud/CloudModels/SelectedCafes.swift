//
//  SelectedCafes.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 22/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import ObjectMapper
import KenticoCloud

class SelectedCafes: DeliveryItem {
    var handpickedCafes: ModularContentElement?
    
    required init?(map: Map){
        super.init(map: map)
        
        let mapper = MapElement.init(map: map)
        handpickedCafes = mapper.map(elementName: "handpicked_cafes", elementType: ModularContentElement.self)
    }
    
    override func mapping(map: Map) {
        
    }
}
