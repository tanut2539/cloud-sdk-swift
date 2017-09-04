import Quick
import Nimble
import KenticoCloud

class ItemsQuerySpec: QuickSpec {
    override func spec() {
        describe("build items query") {
            context("projectID is specified without Preview API key requesting live items", {
                var client:  Client!
                let endpoint: Endpoint! = Endpoint.live
                
                beforeEach {
                    client = Client.init(projectId: "adcae48f-b42b-4a53-a8fc-b3b4501561b9", apiKey: nil)
                }
                
                it("query with content type is built") {
                    let cafeContentType = "cafe"
                    let query = ItemsQuery.init(endpoint: endpoint, contentType: cafeContentType)
                    waitUntil(timeout: 5) { done in
                        client.getItems(query: query, modelType: CafeTestModel.self, completionHandler: { (isSuccess, items) in
                            if !isSuccess {
                                fail("Response is not successful")
                            }
                            if let cafes = items {
                                let cafesCount = cafes.count
                                let expectedCafesCount = 11
                                expect(cafesCount) == expectedCafesCount
                                done()
                            }
                        })
                    }
                }
            })
        }
    }
}
