//
//  SingleItemQuery.swift
//  Pods
//
//  Created by Martin Makarsky on 01/09/2017.
//
//

import Foundation

public class SingleItemQuery: Query {
    private let itemQuery = "items"
    
    private var itemCodeName: String
    
    public init(endpoint: Endpoint, itemCodeName: String, language: String? = nil) {
        self.itemCodeName = itemCodeName
        super.init(endpoint: endpoint, language: language)
    }
    
    func getItemQuery(projectId: String) -> String {
        let endpoint = getEndpoint()
        let languageParameter = getLanguageParameter()
        return "\(endpoint)/\(projectId)/\(itemQuery)/\(itemCodeName)\(languageParameter)"
    }
}
