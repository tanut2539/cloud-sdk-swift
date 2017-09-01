//
//  Query.swift
//  Pods
//
//  Created by Martin Makarsky on 31/08/2017.
//
//

import Foundation

public class Query {
    
    private static let deliverEndpoint = "https://deliver.kenticocloud.com"
    private static let previewDeliverEndpoint = "https://preview-deliver.kenticocloud.com"
    
    private static let itemsQuery = "items?system.type="
    private static let itemQuery = "items"
    
    static func getItemsQuery(contentType: String, projectId: String, isPreview: Bool) -> String {
        let endpoint = getEndpoint(isPreview: isPreview)
        return "\(endpoint)/\(projectId)/\(itemsQuery)\(contentType)"
    }
    
    static func getItemQuery(codeName: String, projectId: String, isPreview: Bool) -> String {
        let endpoint = getEndpoint(isPreview: isPreview)
        return "\(endpoint)/\(projectId)/\(itemQuery)/\(codeName)"
    }
    
    private static func getEndpoint(isPreview: Bool) -> String {
        if isPreview {
            return previewDeliverEndpoint
        }
        
        return deliverEndpoint
    }
}
