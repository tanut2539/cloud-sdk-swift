//
//  CafeCloudModel.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 15/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import ObjectMapper

public class Article: Mappable {
    public var title: String?
    public var summary: String?
    public var postDate: String?
    public var imageUrl: String?
    
    public required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        title <- map["elements.title.value"]
        summary <- map["elements.summary.value"]
        postDate <- map["elements.post_date.value"]
        imageUrl <- map["elements.teaser_image.value.0.url"]
    }
}
