//
//  NotificationService.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 03/10/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Alamofire

class  NotificationService {
    
    private let notifictionServiceEndpoint = "https://applepushnotificationservice.azurewebsites.net/api/subscribers"
    
    func registerForNotifications(deviceToken: String, uid: String) {
        let parameters: Parameters = [
            "DeviceToken": deviceToken,
            "Uid": uid
        ]
        
        Alamofire.request(notifictionServiceEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: getHeaders()).responseData { response in
            print("Register for custom notifications: \(response.description)")
        }
    }
    
    
    private func getHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        return headers
    }
}
