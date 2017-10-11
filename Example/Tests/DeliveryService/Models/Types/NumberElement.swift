//
//  NumberElement.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 11/10/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoCloud

class NumberElementSpec: QuickSpec {
    override func spec() {
        describe("Get number element") {
            
            let client = DeliveryClient.init(projectId: TestConstants.projectId)
            
            //MARK: Properties tests
            
            context("checking properties", {
                
                it("all properties are correct") {
                    
                    waitUntil(timeout: 5) { done in
                        client.getItem(modelType: ArticleTestModel.self, itemName: "on_roasts", completionHandler:
                            { (isSuccess, deliveryItem, error) in
                                if !isSuccess {
                                    fail("Response is not successful. Error: \(String(describing: error))")
                                }
                                
                                if let issue = deliveryItem?.item?.issue {
                                    let expectedType = "number"
                                    let expectedName = "Issue"
                                    let expectedValue = 9.0
                                    expect(issue.type) == expectedType
                                    expect(issue.name) == expectedName
                                    expect(issue.value) == expectedValue
                                    done()
                                }
                        })
                    }
                }
            })
        }
    }
}

