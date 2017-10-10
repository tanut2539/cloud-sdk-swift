//
//  TrackingClient.swift
//  Pods
//
//  Created by Martin Makarsky on 12/09/2017.
//
//

import Alamofire

public class TrackingClient {
    
    private var projectId: String
    private var sid: String
    private var isDebugLoggingEnabled: Bool
    
    public private(set) var uid: String
    
    public init(projectId: String, enableDebugLogging: Bool = false) {
        self.projectId = projectId
        self.sid = TrackingSessionHelper.getSid()
        self.uid = TrackingSessionHelper.getUid()
        self.isDebugLoggingEnabled = enableDebugLogging
    }
    
    public func startSession(completionHandler: @escaping (Bool, Error?) -> () = { _ in }) {
        let sessionRequestUrl = getSessionUrl()
        let body = getSessionRequestBody()
        let headers = getHeaders()
        
        sendTrackingRequest(url: sessionRequestUrl, body: body, headers: headers, debugActionMessage: "Starting session", completionHandler: completionHandler)
    }
    
    public func trackActivity(activityName: String, completionHandler: @escaping (Bool, Error?) -> () = { _ in }) {
        
        let activityRequestUrl = getTrackActivityUrl()
        let body = getActivityRequestBody(activityName: activityName)
        let headers = getHeaders()
        
        sendTrackingRequest(url: activityRequestUrl, body: body, headers: headers, debugActionMessage: "Tracking activity \"\(activityName)\"",completionHandler: completionHandler)
    }
    
    public func addContact(email: String, completionHandler: @escaping (Bool, Error?) -> () = { _ in }) {
        let addContactRequestUrl = getAddContactUrl()
        let body = getAddContactRequestBody(email: email)
        let headers = getHeaders()
        
        sendTrackingRequest(url: addContactRequestUrl, body: body, headers: headers, debugActionMessage: "Adding contact \"\(email)\"", completionHandler: completionHandler)
    }
    
    private func sendTrackingRequest(url: String, body: Parameters, headers: HTTPHeaders, debugActionMessage: String, completionHandler: @escaping (Bool, Error?) -> ()) {
        
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    if self.isDebugLoggingEnabled {
                        print("[Kentico Cloud] \(debugActionMessage) action has succeeded")
                    }
                    completionHandler(true, nil)
                case .failure(let error):
                    if self.isDebugLoggingEnabled {
                        print("[Kentico Cloud] \(debugActionMessage) has failed with error: \(error)")
                    }
                    completionHandler(false, error)
                }
        }
    }
        
    private func getSessionUrl() -> String {
        let endpoint = getTrackerEndpoint()
        return "\(endpoint)/track/\(projectId)/session"
    }
    
    private func getTrackActivityUrl() -> String {
        let endpoint = getTrackerEndpoint()
        return "\(endpoint)/track/\(projectId)/activity"
    }
    
    private func getAddContactUrl() -> String {
        let endpoint = getTrackerEndpoint()
        return "\(endpoint)/track/\(projectId)/contact"
    }
    
    private func getTrackerEndpoint() -> String {
        return CloudConstants.trackerEndpoint
    }
    
    private func getSessionRequestBody() -> Parameters {
        let parameters: Parameters = [
            "uid": "\(self.uid)",
            "sid": "\(self.sid)"
        ]
        
        return parameters
    }
    
    private func getActivityRequestBody(activityName: String) -> Parameters {
        let parameters: Parameters = [
            "uid": "\(self.uid)",
            "sid": "\(self.sid)",
            "name": "\(activityName)"
        ]
        
        return parameters
    }
    
    private func getAddContactRequestBody(email: String) -> Parameters {
        let parameters: Parameters = [
            "email": "\(email)",
            "uid": "\(self.uid)",
            "sid": "\(self.sid)"
        ]
        
        return parameters
    }
    
    private func getHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        return headers
    }
    
}
