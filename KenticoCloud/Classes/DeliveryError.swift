//
//  DeliverError.swift
//  Pods
//
//  Created by Martin Makarsky on 08/09/2017.
//
//

public enum DeliveryError: Error {
    case ApiKeysError(String)
    case QueryBuilderError(String)
}
