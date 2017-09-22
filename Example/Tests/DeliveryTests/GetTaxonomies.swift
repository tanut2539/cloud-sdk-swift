//
//  GetTaxonomies.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 21/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoCloud

class GetTaxonomiesSpec: QuickSpec {
    override func spec() {
        describe("Get taxonomies request") {
            
            let client = DeliveryClient.init(projectId: TestConstants.projectId)
            
            //MARK: Get all taxonomies
            context("getting all taxonomies", {
                
                it("returns list of taxonomies") {
                    
                    waitUntil(timeout: 5) { done in
                        client.getTaxonomies(completionHandler: { (isSuccess, items, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let taxonomies = items {
                                let fstLvl = taxonomies[0].terms?[1].codename
                                let sndLvl = taxonomies[1].terms?[1].codename
                                expect(fstLvl) == "coffee_enthusiast"
                                expect(sndLvl) == "bestseller"
                                done()
                            }
                        })
                    }
                }
            })
            
        }
    }
}
