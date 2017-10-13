//
//  GetContentTypes.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 13/10/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoCloud

class GetContentTypesSpec: QuickSpec {
    override func spec() {
        describe("Get content types request") {
            
            let client = DeliveryClient.init(projectId: TestConstants.projectId)
            
            //MARK: Get all content types
            
            context("getting all content types", {
                
                it("returns list of all content types") {
                    
                    waitUntil(timeout: 5) { done in
                        client.GetContentTypes(completionHandler: { (isSuccess, contentTypesResponse, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let response = contentTypesResponse {
                                expectedCount = 13
                                expect(response.contentTypes.count) == expectedCount
                                done()
                            }
                        })
                    }
                }
            })
        }
    }
}
