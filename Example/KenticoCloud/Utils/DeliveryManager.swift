//
//  CloudClient.swift
//  KenticoCloud_Example
//
//  Created by Martin Makarsky on 10/07/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import KenticoCloud

class DeliveryManager {
    
    // MARK: - Properties
    
    static let shared = DeliveryManager()
    
    // MARK: -
    
    let deliveryClient: DeliveryClient
    
    // Initialization
    
    private init() {
        let projectId = AppConstants.getProjectId()
        let apiKey = AppConstants.tryGetApiKey()
        
        if apiKey == nil || apiKey == "" {
            self.deliveryClient = DeliveryClient.init(projectId: projectId)
        } else {
            self.deliveryClient = DeliveryClient.init(projectId: projectId, apiKey: apiKey)
        }
    }
    
}
