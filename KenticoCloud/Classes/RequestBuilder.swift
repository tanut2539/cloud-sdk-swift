//
//  RequestBuilder.swift
//  Pods
//
//  Created by Martin Makarsky on 11/09/2017.
//
//

class RequestBuilder {
    
    private(set) var endpointUrl: String
    private(set) var projectId: String
    private(set) var queryParameters: [QueryParameter]?
    private(set) var itemName: String?
    private(set) var language: String?

    
    init(endpointUrl: String, projectId: String, queryParameters: [QueryParameter]? = nil, itemName: String? = nil, language: String? = nil ) {
        self.endpointUrl = endpointUrl
        self.projectId = projectId
        
        if let queryParameters = queryParameters {
            self.queryParameters = queryParameters
        }
        
        if let itemName = itemName {
            self.itemName = itemName
        }
    }
    
    func getRequestUrl() -> String {
        
        // In case query is speciefied, we want to get multiple items in array
        if queryParameters != nil {
            return buildItemsRequestUrl()
        }
        
        // In case itemId is specified, we want just this one item
        if itemName != nil {
            return buildItemQuery()
        }
        
        return "\(endpointUrl)/\(projectId)/items"
    }
    
    private func buildItemsRequestUrl() -> String {
        var queryParametersString = "?"
        
        for queryParameter in queryParameters! {
            queryParametersString.append(queryParameter.getQueryStringParameter())
            queryParametersString.append("&")
        }
        queryParametersString = String(queryParametersString.characters.dropLast(1))
        
        return "\(endpointUrl)/\(projectId)/items\(queryParametersString)"
    }
    
    private func buildItemQuery() -> String {
        var languageQueryParameter = ""
        if let language = language {
            languageQueryParameter = "?language=\(language)"
        }
        
        return "\(endpointUrl)/\(projectId)/items/\(itemName!)\(languageQueryParameter)"
    }
}
