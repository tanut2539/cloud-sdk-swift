//
//  DeliverError.swift
//  Pods
//
//  Created by Martin Makarsky on 08/09/2017.
//
//

public enum DeliverError: Error {
    case EndpointError(String)
    case ApiKeysError(String)
}
