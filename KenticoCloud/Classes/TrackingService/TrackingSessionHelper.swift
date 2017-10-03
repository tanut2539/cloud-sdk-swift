//
//  SessionHelper.swift
//  Pods
//
//  Created by Martin Makarsky on 12/09/2017.
//
//

public struct TrackingSessionHelper {
    
    private static let uidKey = "KenticoCloudTrackingSessionUid"
    private static let sidKey = "KenticoCloudTrackingSessionSid"
    
    static func getSid() -> String {
        
        // Try to get existing from local storage
        let sid = UserDefaults.standard.value(forKey: sidKey) as? String
        
        if sid != nil {
            return sid!
        } else {
            let sid = generateNewUid()
            UserDefaults.standard.setValue(sid, forKey: sidKey)
            return sid
        }
    }
    
    public static func getUid() -> String {
        
        // Try to get existing from local storage
        let uid = UserDefaults.standard.value(forKey: uidKey) as? String
        
        if uid != nil {
            return uid!
        } else {
            let uid = generateNewUid()
            UserDefaults.standard.setValue(uid, forKey: uidKey)
            return uid
        }
    }
    
    private static func generateNewUid() -> String {
        return String.randomString(length: 16)
    }
    
    private static func generateNewSid() -> String {
        return String.randomString(length: 16)
    }
}
