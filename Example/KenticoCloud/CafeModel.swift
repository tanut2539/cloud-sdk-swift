//
//  CafeCloudModel.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 15/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import ObjectMapper

class CafesResponse: Mappable {
    var cafes: [Cafe]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        cafes <- map["items"]
    }
}

class Cafe: Mappable {
    var street: String?
    var city: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        street <- map["elements.street.value"]
        city <- map["elements.city.value"]
    }
}

class Ahoj {
    var tmp: string?
}
