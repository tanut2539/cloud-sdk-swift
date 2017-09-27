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
    
    public func getItems<T>(modelType: T.Type, queryParameters: [QueryParameter?], completionHandler: @escaping (Bool, ItemsResponse<T>?, Error?) -> ()) where T: Mappable {
        
        let requestUrl = getItemsRequestUrl(queryParameters: queryParameters)
        sendGetItemsRequest(url: requestUrl, completionHandler: completionHandler)
    }
    
    public func getItems<T>(modelType: T.Type, customQuery: String, completionHandler: @escaping (Bool, ItemsResponse<T>?, Error?) -> ()) where T: Mappable {
        
        let requestUrl = getItemsRequestUrl(customQuery: customQuery)
        sendGetItemsRequest(url: requestUrl, completionHandler: completionHandler)
    }
    
    public func getItem<T>(modelType: T.Type, itemName: String, language: String? = nil, completionHandler: @escaping (Bool, ItemResponse<T>?, Error?) -> ()) where T: Mappable {
        
        let requestUrl = getItemRequestUrl(itemName: itemName, language: language)
        sendGetItemRequest(url: requestUrl, completionHandler: completionHandler)
    }
    
    public func getItem<T>(modelType: T.Type, customQuery: String, completionHandler: @escaping (Bool, ItemResponse<T>?, Error?) -> ()) where T: Mappable {
        
        let requestUrl = getItemRequestUrl(customQuery: customQuery)
        sendGetItemRequest(url: requestUrl, completionHandler: completionHandler)
    }
    
    public func getTaxonomies(customQuery: String? = nil, completionHandler: @escaping (Bool, [TaxonomyGroup]?, Error?) -> ()) {
        
        let requestUrl = getTaxonomiesRequestUrl(customQuery: customQuery)
        sendGetTaxonomiesRequest(url: requestUrl, completionHandler: completionHandler)
    }
    
    public func getTaxonomyGroup(taxonomyGroupName: String, completionHandler: @escaping (Bool, TaxonomyGroup?, Error?) -> ()) {
        
        let requestUrl = getTaxonomyRequestUrl(taxonomyName: taxonomyGroupName)
        sendGetTaxonomyRequest(url: requestUrl, completionHandler: completionHandler)
    }
    
    private func sendGetItemsRequest<T>(url: String, completionHandler: @escaping (Bool, ItemsResponse<T>?, Error?) -> ()) where T: Mappable {
        Alamofire.request(url, headers: self.headers).responseObject { (response: DataResponse<ItemsResponse<T>>) in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let deliveryItems = value
                    if self.isDebugLoggingEnabled {
                        print("[Kentico Cloud] Getting items is successful. Obtained \(String(describing: deliveryItems.items?.count)) items.")
                    }
                    completionHandler(true, deliveryItems, nil)
                }
            case .failure(let error):
                if self.isDebugLoggingEnabled {
                    print("[Kentico Cloud] Getting items failed. Check requested URL: \(url)")
                }
                completionHandler(false, nil, error)
            }
        }
    }
    
    private func sendGetItemRequest<T>(url: String, completionHandler: @escaping (Bool, ItemResponse<T>?, Error?) -> ()) where T: Mappable {
        Alamofire.request(url, headers: self.headers).responseObject() { (response: DataResponse<ItemResponse<T>>) in
            
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
    
    private func sendGetTaxonomiesRequest(url: String, completionHandler: @escaping (Bool, [TaxonomyGroup]?, Error?) -> ()) {
        Alamofire.request(url, headers: self.headers).responseArray(keyPath: "taxonomies") { (response: DataResponse<[TaxonomyGroup]>) in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    if self.isDebugLoggingEnabled {
                        print("[Kentico Cloud] Getting taxonomies successful.")
                    }
                    completionHandler(true, value, nil)
                }
            case .failure(let error):
                if self.isDebugLoggingEnabled {
                    print("[Kentico Cloud] Getting taxonomies failed. Check requested URL: \(url)")
                }
                
                completionHandler(false, [], error)
            }
        }
    }
    
    private func sendGetTaxonomyRequest(url: String, completionHandler: @escaping (Bool, TaxonomyGroup?, Error?) -> ()) {
        Alamofire.request(url, headers: self.headers).responseObject { (response: DataResponse<TaxonomyGroup>) in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    if self.isDebugLoggingEnabled {
                        print("[Kentico Cloud] Getting taxonomies successful.")
                    }
                    completionHandler(true, value, nil)
                }
            case .failure(let error):
                if self.isDebugLoggingEnabled {
                    print("[Kentico Cloud] Getting taxonomies failed. Check requested URL: \(url)")
                }
                
                completionHandler(false, nil, error)
            }
        }
    }
    
    private func getItemsRequestUrl(queryParameters: [QueryParameter?]) -> String {
        
        let endpoint = getEndpoint()
        
        let requestBuilder = ItemsRequestBuilder.init(endpointUrl: endpoint, projectId: projectId, queryParameters: queryParameters)
        
        return requestBuilder.getRequestUrl()
        
        
    }
    
    private func getItemsRequestUrl(customQuery: String) -> String {
        
        let endpoint = getEndpoint()
        
        return "\(endpoint)/\(projectId)/\(customQuery)"
    }
    
    private func getItemRequestUrl(customQuery: String) -> String {
        let endpoint = getEndpoint()
        
        return "\(endpoint)/\(projectId)/\(customQuery)"
    }
    
    private func getItemRequestUrl(itemName: String, language: String? = nil) -> String {
        let endpoint = getEndpoint()
        
        
        var languageQueryParameter = ""
        if let language = language {
            languageQueryParameter = "?language=\(language)"
        }
        
        return "\(endpoint)/\(projectId)/items/\(itemName)\(languageQueryParameter)"
    }
    
    private func getTaxonomiesRequestUrl(customQuery: String?) -> String {
        let endpoint = getEndpoint()
        var queryString = ""
        if let customQuery = customQuery {
            queryString = "?\(customQuery)"
        }
        
        
        return "\(endpoint)/\(projectId)/taxonomies\(queryString)"
    }
    
    private func getTaxonomyRequestUrl(taxonomyName: String) -> String {
        let endpoint = getEndpoint()
        
        return "\(endpoint)/\(projectId)/taxonomies/\(taxonomyName)"
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
    
    // TODO: Add new headers
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