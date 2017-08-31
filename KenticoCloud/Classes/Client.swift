//
//  Client.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 15/08/2017.
//  Copyright © 2017 Martin Makarsky. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire
import ObjectMapper

public class Client {
    
    private let deliverEndpoint = "https://deliver.kenticocloud.com"
    private let previewDeliverEndpoint = "https://preview-deliver.kenticocloud.com"
    
    private let itemsQuery = "items?system.type="
    private let itemQuery = "items"
    
    private var projectId: String
    private var apiKey: String?
    
    public init(projectId: String, apiKey: String) {
        self.projectId = projectId
        self.apiKey = apiKey
    }
    
    public func getItems<T>(contentType: String, modelType: T.Type, isPreview: Bool = false, completionHandler: @escaping (Bool, [T]?) -> ()) where T: Mappable {
        
        let url = getItemsQuery(contentType: contentType, isPreview: isPreview)
        let headers = getHeaders(isPreview: isPreview, apiKey: apiKey)
        
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
    
    public func getItem<T>(codeName: String, modelType: T.Type, isPreview: Bool = false, completionHandler: @escaping (Bool, T?) -> ()) where T: Mappable {
        
        let url = getItemQuery(codeName: codeName, isPreview: isPreview)
        Alamofire.request(url).responseObject(keyPath: "item") { (response: DataResponse<T>) in
            
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
    
    private func getItemsQuery(contentType: String, isPreview: Bool) -> String {
        let endpoint = getEndpoint(isPreview: isPreview)
        return "\(endpoint)/\(projectId)/\(itemsQuery)\(contentType)"
    }
    
    private func getItemQuery(codeName: String, isPreview: Bool) -> String {
        let endpoint = getEndpoint(isPreview: isPreview)
        return "\(endpoint)/\(itemQuery)/\(codeName)"
    }
    
    private func getEndpoint(isPreview: Bool) -> String {
        if isPreview {
            return previewDeliverEndpoint
        }
        
        return deliverEndpoint
    }
    
    private func getHeaders(isPreview: Bool, apiKey: String?) -> HTTPHeaders {
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
