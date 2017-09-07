//
//  Query.swift
//  Pods
//
//  Created by Martin Makarsky on 31/08/2017.
//
//

public enum Endpoint {
    case preview
    case live
}

public class Query {

    var endpoint: Endpoint
    var queryParameters: [QueryParameter]
    
    public init(endpoint: Endpoint, queryParameters: [QueryParameter]) {
        self.queryParameters = queryParameters
        self.endpoint = endpoint
    }
    
    internal func getRequestUrl(projectId: String) -> String {
        let endpoint = EndpointHelper.getEndpointUrl(endpoint: self.endpoint)
        
        var queryParametersString = "?"
        for queryParameter in queryParameters {
            queryParametersString.append(queryParameter.getQueryStringParameter())
            queryParametersString.append("&")
        }
        queryParametersString = String(queryParametersString.characters.dropLast(1))
        
        return "\(endpoint)/\(projectId)/items\(queryParametersString)"
    }
    


}
