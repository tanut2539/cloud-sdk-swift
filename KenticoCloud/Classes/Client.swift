//
//  Client.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 15/08/2017.
//  Copyright © 2017 Martin Makarsky. All rights reserved.
//

import AlamofireObjectMapper
import Alamofire
import ObjectMapper

public class Client {
    
    private var projectId: String
    private var apiKey: String?
    private var headers: HTTPHeaders?
    
    public init(projectId: String, apiKey: String? = nil) {
        self.projectId = projectId
        self.apiKey = apiKey
        headers = getHeaders()
    }
    
    public func getItems<T>(queryParameters: [QueryParameter]? = nil, customQuery: String? = nil, modelType: T.Type, completionHandler: @escaping (Bool, [T]?) -> ()) throws where T: Mappable {
        
        let url = try getItemsRequestUrl(queryParameters: queryParameters, customQuery: customQuery)
        Alamofire.request(url, headers: self.headers).responseArray(keyPath: "items") { (response: DataResponse<[T]>) in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    var items = [T]()
                    items = value
                    completionHandler(true, items)
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
    public func getItem<T>(itemName: String? = nil, customQuery: String? = nil, language: String? = nil, modelType: T.Type, completionHandler: @escaping (Bool, T?) -> ()) throws where T: Mappable {
        
        let requestUrl = try getItemRequestUrl(itemName: itemName, language: language)
        
        Alamofire.request(requestUrl, headers: self.headers).responseObject(keyPath: "item") { (response: DataResponse<T>) in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    completionHandler(true, value)
                }
            case .failure(let error):
                print(error)
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
            return DeliveryConstants.liveEndpoint
        } else {
            return DeliveryConstants.previewEndpoint
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
