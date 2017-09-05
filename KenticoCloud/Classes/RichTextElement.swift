//
//  RichTextElement.swift
//  Pods
//
//  Created by Martin Makarsky on 04/09/2017.
//
//

import ObjectMapper
import Fuzi


public class RichTextElement: Mappable {
    private var elementName: String = ""
    private var supportedBlocks = "//p | //h1 | //h2 | //h3 | //h4 | //strong | //em | //ol | //ul | //a | //object[@type='application/kenticocloud'][@data-type='item'] | //figure"
    // tmp	String?	"<object type=\"application/kenticocloud\" data-type=\"item\" data-codename=\"donate_with_us\"></object>"	some
    
    public private(set) var type: String?
    public private(set) var name: String?
    public private(set) var value: String?
    public private(set) var blocks: [Block] = []
    
    private var imageNames: [String]?
    
    public required init?(map: Map){
        if let context = map.context as? Context {
            elementName = context.elementName
        }
        
        let value = map["elements.\(elementName).value"].currentValue as? String
        
        // let xml = SWXMLHash.parse("")

//        if let value = value {
//            do {
//                let doc = try HTMLDocument(string: value, encoding: .utf8)
//                
//                for block in doc.xpath(supportedBlocks) {
//                    if let tag = block.tag {
//                        switch tag {
//                        case "p", "h1", "h2", "h3", "h4", "ol", "ul":
//                            // blocks.append(HtmlContentBlock.init(html: block.stringValue))
//                            print("hello")
////                        case "object":
////                            //let contentItemBlock = getContentItemBlock(block: block)
////                            //                                blocks.append(ContentItemBlock)
////                        //                                print(block.toHTML)
//                        default:
//                            print("default")
//                        }
//                    }
//                }
//                
//            } catch let error {
//                print(error)
//            }
//
//        }
    }
    
    public func mapping(map: Map) {
        type <- map["elements.\(elementName).type"]
        name <- map["elements.\(elementName).name"]
        imageNames <- map["elements.\(elementName).images"]
        value <- map["elements.\(elementName).value"]
    }
}

