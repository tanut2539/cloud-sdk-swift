//
//  HeadersHelper.swift
//  Pods
//
//  Created by Martin Makarsky on 31/08/2017.
//
//

import Foundation
import Alamofire

class HeadersHelper {

    static func getHeaders(endpoint: Endpoint, apiKey: String?) -> HTTPHeaders {
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
