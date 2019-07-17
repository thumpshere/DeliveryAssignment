//
//  ListViewControllerTest.swift
//  Delivery AssignmentTests
//
//  Created by Arpit Tripathi on 10/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import XCTest
@testable import DeliveryAssignment
class ListViewControllerTest: XCTestCase {
  var deliveryListVC: DeliveryListViewController = DeliveryListViewController()
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    let navController = AppDelegate.delegate().window?.rootViewController as! UINavigationController
    deliveryListVC = navController.viewControllers[0] as! DeliveryListViewController
  }

  func testRequiredElementShouldNotNil() {
    XCTAssertNotNil(deliveryListVC.title)
    XCTAssertNotNil(deliveryListVC.deliveriesTable)
    XCTAssertNotNil(deliveryListVC.refreshControl)
    XCTAssertNotNil(deliveryListVC.noDataLabel)
  }
  
  func testTableViewDelegateDataSource() {
    XCTAssertTrue(deliveryListVC.conforms(to: UITableViewDelegate.self))
    XCTAssertTrue(deliveryListVC.conforms(to: UITableViewDataSource.self))
  }
  
  func testCellConfiguration() {
    let tableView = deliveryListVC.deliveriesTable
    let cell = deliveryListVC.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
    XCTAssertNotNil(cell)
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
