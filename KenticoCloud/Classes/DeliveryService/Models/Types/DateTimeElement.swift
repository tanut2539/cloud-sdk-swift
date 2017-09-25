//
//  DateTimeElement.swift
//  Pods
//
//  Created by Martin Makarsky on 06/09/2017.
//
//

import ObjectMapper

public class DateTimeElement: Mappable {
    public private(set) var type: String?
    public private(set) var name: String?
    public private(set) var value: Date?
    public private(set) var rawValue: String?
    
    public required init?(map: Map){
    }
    
    public func mapping(map: Map) {
        var elementName = ""
        if let context = map.context as? ElementContext {
            elementName = context.elementName
        }
        
        type <- map["elements.\(elementName).type"]
        name <- map["elements.\(elementName).name"]
        rawValue <- (map["elements.\(elementName).value"])
        value = getDateTime(dateTime: rawValue)
    }
    
    private func getDateTime(dateTime: String?) -> Date? {
        if let dateTime = dateTime {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            return dateFormatter.date(from: dateTime)
        }
        
        return nil
    }
}

