//
//  HeadersHelper.swift
//  Pods
//
//  Created by Martin Makarsky on 31/08/2017.
//
//

import Foundation
import Alamofire

public class HeadersHelper {

    static func getHeaders(isPreview: Bool, apiKey: String?) -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        if isPreview {
            if let apiKey = apiKey {
                headers["authorization"] = "Bearer " + apiKey
            }
        }
        
        return headers
    }
}
