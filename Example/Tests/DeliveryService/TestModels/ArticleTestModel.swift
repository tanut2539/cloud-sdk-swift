//
//  ArticleTestModel.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 21/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import ObjectMapper
import KenticoCloud

public class ArticleTestModel: Mappable {
    var title: TextElement?
    var asset: AssetElement?
    var postDate: DateTimeElement?
    var summary: TextElement?
    var bodyCopy: RichTextElement?
    var relatedContent: ModularContentElement?
    var targetAudience: MultipleChoiceElement?
    var issue: NumberElement?
    
    public required init?(map: Map){
        let mapper = MapElement.init(map: map)
        title = mapper.map(elementName: "title", elementType: TextElement.self)
        asset = mapper.map(elementName: "teaser_image", elementType: AssetElement.self)
        postDate = mapper.map(elementName: "post_date", elementType: DateTimeElement.self)
        summary = mapper.map(elementName: "summary", elementType: TextElement.self)
        bodyCopy = mapper.map(elementName: "body_copy", elementType: RichTextElement.self)
        relatedContent = mapper.map(elementName: "related_articles", elementType: ModularContentElement.self)
        targetAudience = mapper.map(elementName: "target_audience", elementType: MultipleChoiceElement.self)
        issue = mapper.map(elementName: "issue", elementType: NumberElement.self)
    }
    
    public func mapping(map: Map) {
        
    }
}
