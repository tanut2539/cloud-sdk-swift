//
//  AppConstants.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 31/08/2017.
//  Copyright © 2017 Kentico Software. All rights reserved.
//

import  UIKit

struct AppConstants {
    private static let fallbackProjectId = "6d45fcfe-f4be-0005-0a6b-4e21e77bbbe1"
    
    static let globalBackgroundColor = UIColor.init(red: 255.0/256, green: 250.0/256, blue: 236.0/256, alpha: 1.0)
    static let imageBorderColor = UIColor.init(red: 215.0/256, green: 215.0/256, blue: 215.0/256, alpha: 1.0)
    
    static func getProjectId() -> String {
        if (UserDefaults.standard.bool(forKey: "isAppetize")) {
            return UserDefaults.standard.string(forKey: "projectId") ?? fallbackProjectId
        } else {
            return fallbackProjectId;
        }
    }
    
    static func tryGetApiKey() -> String {
        if (UserDefaults.standard.bool(forKey: "isAppetize")) {
            return UserDefaults.standard.string(forKey: "apiKey") ?? ""
        } else {
            return "";
        }
    }
}
