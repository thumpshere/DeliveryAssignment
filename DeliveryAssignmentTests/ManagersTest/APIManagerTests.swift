//
//  APIManagerTests.swift
//  DeliveryAssignmentTests
//
//  Created by Arpit Tripathi on 06/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import XCTest
@testable import DeliveryAssignment

class APIManagerTests: XCTestCase {
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testDelivery() {
    testDeliveriesForURL(host: "mock-api-mobile.dev.lalamove.com", fileName: "Delivery.json")
  }
  
  private func testDeliveriesForURL(host: String, fileName: String) {
    XCHttpStub.request(withPathRegex: host, withResponseFile: fileName)
    let responseExpectation = expectation(description: "return expected data of List")
    let apiRequestManager: APIManagerProtocol = ApiManager()
    apiRequestManager.fetchDeliveries(offset: 0, limit: 20, success: { (modelArray) in
      XCTAssertNotNil(modelArray, "expected result")
      XCTAssertEqual(20, modelArray.count)
      responseExpectation.fulfill()
    }, failure: { (error) in
      XCTAssertNotNil(error, "error: Expectation fulfilled with error")
    })
    waitForExpectations(timeout: 50) { error in
      if let error = error {
        XCTAssertNotNil(error, "Failed to get response from list webservice")
      }
    }
    
  }
  
  func testDeliveryForInvalidDataFormat() {
    testDeliveriesForInvalidData(host: "mock-api-mobile.dev.lalamove.com", fileName: "InvalidDelivery.json")
  }
  
  private func testDeliveriesForInvalidData(host: String, fileName: String) {
    XCHttpStub.request(withPathRegex: host, withResponseFile: fileName)
    let responseExpectation = expectation(description: "Data not in correct format")
    let apiRequestManager: APIManagerProtocol = ApiManager()
    apiRequestManager.fetchDeliveries(offset: 0, limit: 20, success: { (modelArray) in
      XCTAssertEqual(modelArray.count, 0, "error: item should be empty")
      responseExpectation.fulfill()
    }, failure: { (error) in
      XCTAssertNotNil(error, "error: Expectation fulfilled with error")
      responseExpectation.fulfill()
    })
    waitForExpectations(timeout: 50) { error in
      if let error = error {
        XCTAssertNotNil(error, "Failed to get response from list webservice")
      }
    }
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
