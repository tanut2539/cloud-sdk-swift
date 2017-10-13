//
//  GetContentType.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 13/10/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoCloud

class GetContentTypeSpec: QuickSpec {
    override func spec() {
        describe("Get content type request") {
            
            let client = DeliveryClient.init(projectId: TestConstants.projectId)
            
            //MARK: Get some content types
            
            context("getting content type using content type name", {
                
                it("returns content type with correct name and codename") {
                    
                    waitUntil(timeout: 5) { done in
                        client.getContentType(name: "coffee", completionHandler: { (isSuccess, contentType, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let type = contentType {
                                let expectedName = "Coffee"
                                let expecedCodename = "coffee"
                                expect(type.name) == expectedName
                                expect(type.codename) == expecedCodename
                                done()
                            }
                        })
                    }
                }
            })
        }
    }
}

