//
//  DeliveryClient.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 15/08/2017.
//  Copyright © 2017 Martin Makarsky. All rights reserved.
//

import AlamofireObjectMapper
import Alamofire
import ObjectMapper

public class DeliveryClient {
    
    private var projectId: String
    private var apiKey: String?
    private var headers: HTTPHeaders?
    private var isDebugLoggingEnabled: Bool
    
    public init(projectId: String, apiKey: String? = nil, enableDebugLogging: Bool = false) {
        self.projectId = projectId
        self.apiKey = apiKey
        self.isDebugLoggingEnabled = enableDebugLogging
        self.headers = getHeaders()
    }
    
    public func getItems<T>(modelType: T.Type, queryParameters: [QueryParameter]? = nil, customQuery: String? = nil, completionHandler: @escaping (Bool, [T]?, Error?) -> ()) throws where T: Mappable {
        
        let requestUrl = try getItemsRequestUrl(queryParameters: queryParameters, customQuery: customQuery)
        sendGetItemsRequest(url: requestUrl, completionHandler: completionHandler)
    }
    
    public func getItem<T>(modelType: T.Type, itemName: String? = nil, language: String? = nil, customQuery: String? = nil, completionHandler: @escaping (Bool, T?, Error?) -> ()) throws where T: Mappable {
        
        let requestUrl = try getItemRequestUrl(itemName: itemName, language: language)
        sendGetItemRequest(url: requestUrl, completionHandler: completionHandler)
    }
    
    private func sendGetItemsRequest<T>(url: String, completionHandler: @escaping (Bool, [T]?, Error?) -> ()) where T: Mappable {
        Alamofire.request(url, headers: self.headers).responseArray(keyPath: "items") { (response: DataResponse<[T]>) in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    var items = [T]()
                    items = value
                    if self.isDebugLoggingEnabled {
                        print("[Kentico Cloud] Getting items is successful. Obtained \(items.count) items.")
                    }
                    completionHandler(true, items, nil)
                }
            case .failure(let error):
                if self.isDebugLoggingEnabled {
                    print("[Kentico Cloud] Getting items failed. Check requested URL: \(url)")
                }
                completionHandler(false, nil, error)
            }
        }
    }
    
    private func sendGetItemRequest<T>(url: String, completionHandler: @escaping (Bool, T?, Error?) -> ()) where T: Mappable {
        Alamofire.request(url, headers: self.headers).responseObject(keyPath: "item") { (response: DataResponse<T>) in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    if self.isDebugLoggingEnabled {
                        print("[Kentico Cloud] Getting item is successful.")
                    }
                    completionHandler(true, value, nil)
                }
            case .failure(let error):
                if self.isDebugLoggingEnabled {
                    print("[Kentico Cloud] Getting items failed. Check requested URL: \(url)")
                }
                completionHandler(false, nil, error)
            }
        }
    }
    
    private func getItemsRequestUrl(queryParameters: [QueryParameter]? = nil, customQuery: String? = nil) throws -> String {
        
        let endpoint = getEndpoint()
        
        if let customQuery = customQuery {
            return "\(endpoint)/\(projectId)/\(customQuery)"
        }
        
        if let queryParameters = queryParameters {
            return ItemsRequestBuilder.init(endpointUrl: endpoint, projectId: projectId, queryParameters: queryParameters).getRequestUrl()
        }
        
        throw DeliveryError.QueryError("You must specify queryParameters or customQuery")
    }
    
    private func getItemRequestUrl(customQuery: String? = nil, itemName: String? = nil, language: String? = nil) throws -> String {
        let endpoint = getEndpoint()
        
        if let customQuery = customQuery {
            return "\(endpoint)/\(projectId)/\(customQuery)"
        }
        
        if let itemName = itemName {
            var languageQueryParameter = ""
            if let language = language {
                languageQueryParameter = "?language=\(language)"
            }
            
            return "\(endpoint)/\(projectId)/items/\(itemName)\(languageQueryParameter)"
        }
        
        throw DeliveryError.QueryError("You must specify customQuery or itemName")
    }
    
    private func getEndpoint() -> String {
        
        var endpoint: String?
        
        // Check override from property list first
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            if let propertyList = NSDictionary(contentsOfFile: path) {
                if let customEndpoint = propertyList["KenticoCloudDeliveryEndpoint"] {
                    endpoint = customEndpoint as? String
                    return endpoint!
                }
            }
        }
        
        // We want to request preview api in case there is an apiKey
        if apiKey == nil {
            return CloudConstants.liveDeliverEndpoint
        } else {
            return CloudConstants.previewDeliverEndpoint
        }
        
    }
    
    private func getHeaders() -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        if let apiKey = apiKey {
            headers["authorization"] = "Bearer " + apiKey
        }
        
        return headers
    }
}
