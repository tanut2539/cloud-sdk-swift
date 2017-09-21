//
//  StartSession.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 21/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//


import Quick
import Nimble
import KenticoCloud

class StartSessionSpec: QuickSpec {
    override func spec() {
        describe("Create session") {
            
            let client = TrackingClient.init(projectId: TestConstants.projectId)
            
            //MARK: Create session
            context("with specific uid and sid", {
                
                it("session in created") {

                    waitUntil(timeout: 5) { done in
                        client.startSession(completionHandler:  {(isSuccess, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if error == nil {
                                done()
                            } else {
                                fail("Creating session is not successful. Error: \(String(describing: error))")
                            }
                        })
                    }
                }
            })
            
        }
    }
}

