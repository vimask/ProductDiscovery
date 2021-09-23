//
//  ProductDiscovery_VinhVoTests.swift
//  ProductDiscovery_VinhVoTests
//
//  Created by vxvinh on 5/26/21.
//

import XCTest
import Combine

@testable import ProductDiscovery_VinhVo

class ProductDiscovery_VinhVoTests: XCTestCase {

    var expectation:XCTestExpectation?
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    
    
    func testApiCall() {
        expectation = expectation(description: "asynchronous request")
        ProductProvider().getProductList().sink(receiveCompletion: { _ in})
        { (products) in
            XCTAssert(products.count != 0, "data is not matching the server data")
            self.expectation?.fulfill()
        }.store(in: &cancellables)
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
}
