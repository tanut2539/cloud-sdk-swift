//
//  GetModularContent.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 9/23/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoCloud

class GetModularContentItemSpec: QuickSpec {
    override func spec() {
        describe("Get modular content from Item response") {
            
            let client = DeliveryClient.init(projectId: TestConstants.projectId)
            
            context("using specific codename", {
                
                it("returns modualr content item") {
                    waitUntil(timeout: 5) { done in
                        client.getItem(modelType: ArticleTestModel.self, itemName: "on_roasts", completionHandler: { (isSuccess, itemResponse, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let item = itemResponse?.item {
                                let itemRelatedContent = item.relatedContent
                                let originsOfArabicaCodeName = itemRelatedContent?.value?[1]
                                let coffeeItem = itemResponse?.getModularContent(codename: originsOfArabicaCodeName!, type: ArticleTestModel.self)
                                expect(coffeeItem?.title?.value) == "Origins of Arabica Bourbon"
                                done()
                            }
                        })
                    }
                }
            })
        }
    }
}
