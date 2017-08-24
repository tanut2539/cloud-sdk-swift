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
    
    private let baseUrl = "https://deliver.kenticocloud.com"
    private let itemsQuery = "items?system.type="
    private let itemQuery = "items"
    
    private var projectId: String
    
    public init(projectId: String) {
        self.projectId = projectId
    }
    
    public func getItems<T>(contentType: String, modelType: T.Type, completionHandler: @escaping (Bool, [T]?) -> ()) where T: Mappable {
        
        let url = buildGetItemsQuery(type: contentType)
        
        Alamofire.request(url).responseArray(keyPath: "items") { (response: DataResponse<[T]>) in
            
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
    
    public func getItem<T>(codeName: String, modelType: T.Type, completionHandler: @escaping (Bool, T?) -> ()) where T: Mappable {
        
        let url = buildGetItemQuery(codeName: codeName)
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
    
    private func buildGetItemsQuery(type: String) -> String {
        let cloudEndpoint = getEndpoint(baseUrl: baseUrl, projectId: projectId)
        return "\(cloudEndpoint)/\(itemsQuery)\(type)"
    }
    
    private func buildGetItemQuery(codeName: String) -> String {
        let cloudEndpoint = getEndpoint(baseUrl: baseUrl, projectId: projectId)
        return "\(cloudEndpoint)/\(itemQuery)/\(codeName)"
    }
    
    private func getEndpoint(baseUrl: String, projectId: String) -> String {
        return "\(baseUrl)/\(projectId)"
    }
}
