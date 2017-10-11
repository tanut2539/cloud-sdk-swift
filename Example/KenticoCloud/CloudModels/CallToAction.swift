//
//  CallToAction.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 22/09/2017.
//  Copyright © 2017 Kentico Software. All rights reserved
//

import ObjectMapper
import KenticoCloud

class CallToAction: Mappable {
    
    // MARK: Properties
    
    var image: AssetElement?
    var title: TextElement?
    var text: TextElement?
    var shortText: TextElement?
    var actionButtonText: TextElement?
    var persona: TaxonomyElement?
    var externalLink: TextElement?
    var customActivityName: TextElement?
    
    // MARK: Mapping
    
    public required init?(map: Map){
        let mapper = MapElement.init(map: map)
        
        image = mapper.map(elementName: "image", elementType: AssetElement.self)
        title = mapper.map(elementName: "title", elementType: TextElement.self)
        text = mapper.map(elementName: "text", elementType: TextElement.self)
        shortText = mapper.map(elementName: "short_text", elementType: TextElement.self)
        actionButtonText = mapper.map(elementName: "action_button_text", elementType: TextElement.self)
        persona = mapper.map(elementName: "persona", elementType: TaxonomyElement.self)
        externalLink = mapper.map(elementName: "external_link", elementType: TextElement.self)
        customActivityName = mapper.map(elementName: "custom_activity_name", elementType: TextElement.self)

    }
    
    public func mapping(map: Map) {
    }
}
