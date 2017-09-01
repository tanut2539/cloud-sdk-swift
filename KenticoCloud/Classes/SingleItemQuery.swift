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
    
    public init(endpoint: Endpoint, itemCodeName: String) {
        self.itemCodeName = itemCodeName
        super.init(endpoint: endpoint)
    }
    
    func getItemQuery(projectId: String) -> String {
        let endpoint = getEndpoint()
        return "\(endpoint)/\(projectId)/\(itemQuery)/\(itemCodeName)"
    }
}
