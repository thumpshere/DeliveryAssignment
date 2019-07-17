//
//  DeliveryDetailViewControllerTest.swift
//  DeliveryAssignmentTests
//
//  Created by Arpit Tripathi on 11/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import XCTest
import MapKit
@testable import DeliveryAssignment

class DeliveryDetailViewControllerTest: XCTestCase {
  var deliveryDetailVC: DetailViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      let deliveryItem = getDeliveryListObject()[0]
      let deliveryDetailViewModel = DetailViewModel.init(delivery: deliveryItem)
      deliveryDetailVC = DetailViewController()
      deliveryDetailVC.viewModel = deliveryDetailViewModel
    }

private func getDeliveryListObject() -> [ListObject] {
    
    var deliveryItem = NSMutableDictionary()
    var location = NSMutableDictionary()
    location = ["lat": 28.23, "lng": 78.00, "address": "This is dummy address"]
    deliveryItem = ["id": 0, "description": "This is dummy description", "imageUrl": "This is dummy image path", "location": location]
    let ary = NSArray(object: deliveryItem)
    
    do {
      let decoder = JSONDecoder()
      let data = try? JSONSerialization.data(withJSONObject: ary, options: [])
      let parsedArray = try decoder.decode([ListObject].self, from: data!)
      return parsedArray
      
    } catch let err {
      print("Err", err)
      let arrayEmpty = [ListObject]()
      return arrayEmpty
    }
  }
  
  func testRequiredElementShouldNotNil() {
    XCTAssertNotNil(deliveryDetailVC.viewModel)
  }
  
  func testIfDataIsPresent () {
    XCTAssertNotNil(deliveryDetailVC.viewModel?.deliveryDataObject)
  }
  
  func testMapIsNotNil () {
     XCTAssertNotNil(deliveryDetailVC.mapView)
  }
  
  func testMapViewDelegate () {
    XCTAssertTrue(deliveryDetailVC.conforms(to: MKMapViewDelegate.self))
  }
  
  func testDetailViewIsVisible () {
    deliveryDetailVC.createUI()
    XCTAssert(deliveryDetailVC.deliveryDetailView.isDescendant(of: deliveryDetailVC.view))
  }
  
  func testDetailViewIsNotNil () {
    XCTAssertNotNil(deliveryDetailVC.deliveryDetailView)
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
