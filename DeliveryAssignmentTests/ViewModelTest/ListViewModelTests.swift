//
//  ListViewModelTests.swift
//  Delivery AssignmentTests
//
//  Created by Arpit Tripathi on 06/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import XCTest
import Cache
@testable import DeliveryAssignment

class ListViewModelTests: XCTestCase {
  
  var dataArray = [ListObject]()
  var listViewModel = ListViewModel()
  var mockAPIRequestManager: MockAPIManager!
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    mockAPIRequestManager = MockAPIManager()
    listViewModel.apiRequestManager = mockAPIRequestManager
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    mockAPIRequestManager = nil
  }
  
  func testFetchItemsWithSuccess() {
    listViewModel.deliveries.removeAll()
    listViewModel.shouldRefresh = true
    listViewModel.dataStoreKey = Constants.testObjectKey
    listViewModel.getDataForList()
    XCTAssertEqual(listViewModel.deliveries.count, 1)
    getViewModelForDeliveryDetail()
  }  
  
  private func getDataFromPlist () -> [ListObject]? {
    if let path = Bundle.main.path(forResource: "DummyApiResponse", ofType: "plist") {
      if let ary = NSArray(contentsOfFile: path) {
        return self.createParsedArray(array: ary)
      }
    }
    return nil
  }
  
  private func createParsedArray(array: NSArray) -> [ListObject]? {
    do {
      let decoder = JSONDecoder()
      let data = try? NSKeyedArchiver.archivedData(withRootObject: dataArray, requiringSecureCoding: false)
      let parsedArray = try decoder.decode([ListObject].self, from: data!)
      return parsedArray
      
    } catch let err {
      print("Err", err)
      return nil
    }
  }
  
  func testDecodedData() {
    if  let ary = self.getDataFromPlist() {
      XCTAssertTrue(ary.count == 5)
    }
  }
  
  func getViewModelForDeliveryDetail () {
   let viewModel =  listViewModel.getViewModelForIndex(index: 0)
    XCTAssert(viewModel.isKind(of: DetailViewModel.self))
  }
  
  func testIfDataIsEmpty() {
    XCTAssert(listViewModel.deliveries.isEmpty)
  }
  
}

class MockAPIManager: APIManagerProtocol {
  func fetchDeliveries(offset: Int, limit: Int, success successBlock: @escaping (([ListObject]) -> Void), failure failureBlock: @escaping ((AnyObject) -> Void)) {
    print("Calling mock API")
    successBlock( parsedArrayWithItem() ?? [ListObject]())
  }
  
  private func parsedArrayWithItem() -> [ListObject]? {
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
}
