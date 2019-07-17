//
//  AssignmentHelperTests.swift
//  DeliveryAssignmentTests
//
//  Created by Arpit Tripathi on 16/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import XCTest
@testable import DeliveryAssignment

class AssignmentHelperTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

  func testAlert () {
    AssignmentHelper.showAlert(title: "test", message: "message") {
      XCTAssert(true)
    }
  }
  
  func testLocalisedExtension () {
    XCTAssertTrue("OK".localized == "OK")
  }
  
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
