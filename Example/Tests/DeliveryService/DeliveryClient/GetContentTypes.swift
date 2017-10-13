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
            
            context("getting some content types", {
                
                it("returns list of some content types") {
                    
                    waitUntil(timeout: 5) { done in
                        client.getContentTypes(skip: 2, limit: 4, completionHandler: { (isSuccess, contentTypesResponse, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let response = contentTypesResponse {
                                expectedCount = 4
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
