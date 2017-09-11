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
    
    public init(projectId: String, apiKey: String? = nil) {
        self.projectId = projectId
        self.apiKey = apiKey
    }
    
    public func getItems<T>(queryParameters: [QueryParameter], modelType: T.Type, completionHandler: @escaping (Bool, [T]?) -> ()) throws where T: Mappable {
        
        let url = getRequestUrl(queryParameters: queryParameters)
        let headers = getHeaders()
        
        Alamofire.request(url, headers: headers).responseArray(keyPath: "items") { (response: DataResponse<[T]>) in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    var items = [T]()
                    items = value
                    completionHandler(true, items)
                }
            case .failure(let error):
                print(response)
                print(error)
            }
            
        }
    }
    
    public func getItems<T>(customQuery: String, modelType: T.Type, completionHandler: @escaping (Bool, [T]?) -> ()) throws where T: Mappable {
        
        let endpoint = getEndpoint()
        let requestUrl = "\(endpoint)/\(projectId)/\(customQuery)"
        let headers = getHeaders()
        
        Alamofire.request(requestUrl, headers: headers).responseArray(keyPath: "items") { (response: DataResponse<[T]>) in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    var items = [T]()
                    items = value
                    completionHandler(true, items)
                }
            case .failure(let error):
                print(response)
                print(error)
            }
            
        }
    }
    
    public func getItem<T>(itemName: String, language: String? = nil, modelType: T.Type, completionHandler: @escaping (Bool, T?) -> ()) where T: Mappable {
        
        let requestUrl = getRequestUrl(itemName: itemName, language: language)
        let headers = getHeaders()
        
        Alamofire.request(requestUrl, headers: headers).responseObject(keyPath: "item") { (response: DataResponse<T>) in
            
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
    
    public func getItem<T>(customQuery: String, modelType: T.Type, completionHandler: @escaping (Bool, T?) -> ()) throws where T: Mappable {
        
        let endpoint = getEndpoint()
        let requestUrl = "\(endpoint)/\(projectId)/\(customQuery)"
        let headers = getHeaders()
        
        Alamofire.request(requestUrl, headers: headers).responseObject(keyPath: "item") { (response: DataResponse<T>) in
            
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
    
    private func getRequestUrl(queryParameters: [QueryParameter]? = nil, itemName: String? = nil, language: String? = nil) -> String {
        let endpoint = getEndpoint()
        let requestBuilder = RequestBuilder.init(endpointUrl: endpoint, projectId: projectId, queryParameters: queryParameters, itemName: itemName, language: language)
        
        return requestBuilder.getRequestUrl()
    }
    
    private func getEndpoint() -> String {
        
        var endpoint: String?
        
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            if let propertyList = NSDictionary(contentsOfFile: path) {
                if let customEndpoint = propertyList["KenticoCloudDeliveryEndpoint"] {
                    endpoint = customEndpoint as? String
                }
            }
        }
        
        if endpoint == nil {
            if apiKey == nil {
                endpoint = DeliveryConstants.liveEndpoint
            } else {
                endpoint = DeliveryConstants.previewEndpoint
            }
        }
        
        return endpoint!
    }
    
    private func getHeaders() -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        if let apiKey = self.apiKey {
            headers["authorization"] = "Bearer " + apiKey
        }
        
        return headers
    }
}
