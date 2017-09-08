//
//  Helpers.swift
//  Pods
//
//  Created by Martin Makarsky on 08/09/2017.
//
//

import Alamofire

struct EndpointHelper {
    
    internal static func getEndpointUrl(endpoint: Endpoint) -> String {
        switch endpoint {
        case .preview:
            return DeliverConstants.previewEndpoint
        case .live:
            return DeliverConstants.liveEndpoint
        }
    }
    
}

struct HeadersHelper {
    
    static func getHeaders(endpoint: Endpoint, apiKey: String?) throws -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "Accept": "application/json"
        ]

        if endpoint == Endpoint.preview {
            if let apiKey = apiKey {
                headers["authorization"] = "Bearer " + apiKey
            } else {
                 throw DeliverError.ApiKeysError("ApiKey is necessary while requesting preview API")
            }
        }
        
        return headers
    }
}
