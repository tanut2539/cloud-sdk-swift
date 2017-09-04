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
    
    private var projectId: String
    private var apiKey: String?
    
    public init(projectId: String, apiKey: String) {
        self.projectId = projectId
        self.apiKey = apiKey
    }
    
    public func getItems<T>(query: ItemsQuery, modelType: T.Type, completionHandler: @escaping (Bool, [T]?) -> ()) where T: Mappable {
        
        let url = query.getItemsQuery(projectId: self.projectId)
        let headers = HeadersHelper.getHeaders(endpoint: query.endpoint, apiKey: apiKey)
        
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
    
    public func getItem<T>(query: SingleItemQuery, modelType: T.Type, completionHandler: @escaping (Bool, T?) -> ()) where T: Mappable {
        
        let url = query.getItemQuery(projectId: projectId)
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
}
