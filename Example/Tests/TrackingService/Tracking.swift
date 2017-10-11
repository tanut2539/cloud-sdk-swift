//
//  Tracking
//  KenticoCloud
//
//  Created by Martin Makarsky on 21/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoCloud

class TrackingSpec: QuickSpec {
    override func spec() {
        describe("Tracking") {
            
            let client = TrackingClient.init(projectId: TestConstants.projectId)
            
            //TODO: Find a better way to wait for initiating the session
            client.startSession()
            sleep(3)
            
            //MARK: Log activity
            context("log custom activity", {
                
                it("activity is logged") {
                    
                    waitUntil(timeout: 5) { done in
                        client.trackActivity(activityName: "Page view activity", completionHandler:  {(isSuccess, error) in
                            if !isSuccess {
                                fail("Tracking activity failed. Error: \(String(describing: error))")
                            }
                            
                            if error == nil {
                                done()
                            } else {
                                fail("Tracking activity is not successful. Error: \(String(describing: error))")
                            }
                        })
                    }
                }
            })
            
            //MARK: Add contact
            context("add contact", {
                
                it("contact is added") {
                    
                    waitUntil(timeout: 5) { done in
                        client.addContact(email: "martinkoklingacik@local.com", completionHandler:  {(isSuccess, error) in
                            if !isSuccess {
                                fail("Adding contact failed. Error: \(String(describing: error))")
                            }
                            
                            if error == nil {
                                done()
                            } else {
                                fail("Adding contact is not successful. Error: \(String(describing: error))")
                            }
                        })
                    }
                }
            })
            
        }
    }
}
