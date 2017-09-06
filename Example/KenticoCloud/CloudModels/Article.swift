//
//  CafeCloudModel.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 15/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import ObjectMapper
import KenticoCloud

class Article: Mappable {
    var title: String?
    var summary: String?
    var postDate: String?
    var body: String?
    var imageUrl: String?
    
    required init?(map: Map){

    }
    
    func mapping(map: Map) {
        title <- map["elements.title.value"]
        summary <- map["elements.summary.value"]
        postDate <- map["elements.post_date.value"]
        body <- map["elements.body_copy.value"]
        imageUrl <- map["elements.teaser_image.value.0.url"]
    }
}
