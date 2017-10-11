//
//  MultipleChoiceElement.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 11/10/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoCloud

class MultipleChoiceElementSpec: QuickSpec {
    override func spec() {
        describe("Get multiple choice element") {
            
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
                                
                                if let targetAudience = deliveryItem?.item?.targetAudience {
                                    let expectedType = "multiple_choice"
                                    let expectedName = "Target audience"
                                    let expectedFstChoiceName = "mobile"
                                    let expectedSndChoiceCodename = "iot"
                                    expect(targetAudience.type) == expectedType
                                    expect(targetAudience.name) == expectedName
                                    expect(targetAudience.value?[0].name) == expectedFstChoiceName
                                    expect(targetAudience.value?[1].codename) == expectedSndChoiceCodename
                                    done()
                                }
                        })
                    }
                }
            })
        }
    }
}
