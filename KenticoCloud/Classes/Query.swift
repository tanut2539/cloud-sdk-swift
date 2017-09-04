//
//  Query.swift
//  Pods
//
//  Created by Martin Makarsky on 31/08/2017.
//
//

import Foundation

public enum Endpoint {
    case preview
    case live
}

public class Query {
    
    private let deliverLiveEndpoint = "https://deliver.kenticocloud.com"
    private let previewDeliverEndpoint = "https://preview-deliver.kenticocloud.com"
    
    var endpoint: Endpoint
    var language: String?
    
    internal init(endpoint: Endpoint, language: String?) {
        self.endpoint = endpoint
        self.language = language
    }
    
    func getEndpoint() -> String {
        switch self.endpoint {
        case .preview:
            return previewDeliverEndpoint
        case .live:
            return deliverLiveEndpoint
        }
    }
    
    func getLanguageParameter() -> String{
        if language != nil {
            return "&language=\(language ?? "")"
        }
        
        return ""
    }
}
