//
//  SelectedCafes.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 22/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import ObjectMapper
import KenticoCloud

class SelectedCafes: Mappable {
    var handpickedCafes: ModularContentElement?
    
    required init?(map: Map){
        let mapper = MapElement.init(map: map)
        handpickedCafes = mapper.map(elementName: "handpicked_cafes", elementType: ModularContentElement.self)
    }
    
    public func mapping(map: Map) {
        
    }
}
