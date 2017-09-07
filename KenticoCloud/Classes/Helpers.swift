//
//  Helpers.swift
//  Pods
//
//  Created by Martin Makarsky on 07/09/2017.
//
//

import Alamofire

internal struct EndpointHelper {
    
    private static let deliverLiveEndpoint = "https://deliver.kenticocloud.com"
    private static let previewDeliverEndpoint = "https://preview-deliver.kenticocloud.com"
    
    internal static func getEndpointUrl(endpoint: Endpoint) -> String {
        switch endpoint {
        case .preview:
            return previewDeliverEndpoint
        case .live:
            return deliverLiveEndpoint
        }
    }
}

internal struct HeadersHelper {
    
    internal static func getHeaders(endpoint: Endpoint, apiKey: String?) -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        if endpoint == Endpoint.preview {
            if let apiKey = apiKey {
                headers["authorization"] = "Bearer " + apiKey
            }
        }
        
        return headers
    }
}
