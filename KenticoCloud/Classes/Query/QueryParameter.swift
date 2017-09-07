//
//  QueryParameter.swift
//  Pods
//
//  Created by Martin Makarsky on 07/09/2017.
//
//

public class QueryParameter {
    public private(set) var parameterKey: QueryParameterKey
    public private(set) var parameterValue: String
    
    public init(parameterKey: QueryParameterKey, parameterValue: String) {
        self.parameterKey = parameterKey
        self.parameterValue = parameterValue
    }
    
    internal func getQueryStringParameter() -> String {
        return self.parameterKey.rawValue + "=" + self.parameterValue
    }
}
