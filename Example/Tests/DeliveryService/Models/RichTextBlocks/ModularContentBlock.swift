//
//  ModularContentBlock.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 11/10/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoCloud

class ModularContentBlockSpec: QuickSpec {
    override func spec() {
        describe("Get modular content block") {
            
            let client = DeliveryClient.init(projectId: TestConstants.projectId)
            
            //MARK: Name tests
            
            context("checking name", {
                
                it("returns proper name") {
                    
                    waitUntil(timeout: 5) { done in
                        client.getItem(modelType: ArticleTestModel.self, itemName: "on_roasts", completionHandler:
                            { (isSuccess, deliveryItem, error) in
                                if !isSuccess {
                                    fail("Response is not successful. Error: \(String(describing: error))")
                                }
                                
                                if let modularContentBlock = deliveryItem?.item?.bodyCopy?.modularContent.first {
                                    let expectedName = "coffee_processing_techniques"
                                    expect(modularContentBlock?.contentItemName) == expectedName
                                    done()
                                }
                        })
                    }
                }
            })
        }
    }
}
