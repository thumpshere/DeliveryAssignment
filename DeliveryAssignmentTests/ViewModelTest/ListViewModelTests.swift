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
    listViewModel.dataModelArray.removeAll()
    listViewModel.shouldRefresh = true
    listViewModel.dataStoreKey = Constants.testObjectKey
    listViewModel.getDataForList()
    XCTAssertEqual(listViewModel.dataModelArray.count, 1)
  }
  
  func getDataFromPlist () -> [ListObject]? {
    if let path = Bundle.main.path(forResource: "DummyApiResponse", ofType: "plist") {
      if let ary = NSArray(contentsOfFile: path) {
        return self.createParsedArray(array: ary)
      }
    }
    return nil
  }
  
  func createParsedArray(array: NSArray) -> [ListObject]? {
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
  
  func testIfDataIsWrittenAndDeletedFromCache() {
    if  let ary = self.getDataFromPlist() {
      let listVM = ListViewModel()
      listVM.saveDataToCache(data: ary, keyString: "dummyDataForCache")
      listVM.getDataFromCache(keyString: "dummyDataForCache")
      XCTAssertTrue(listVM.dataModelArray.count>0)
      listVM.deleteDataFromCache(keyString: "dummyDataForCache")
      listVM.getDataFromCache(keyString: "dummyDataForCache")
      XCTAssertFalse(listVM.dataModelArray.count>0)
    }
  }
  
  func testIfDataIsEmpty() {
    XCTAssert(listViewModel.isDataEmpty())
  }

}

class MockAPIManager: APIManagerProtocol {
  func getDataToBeShownIntoList(offset: Int, limit: Int, success successBlock: @escaping (([ListObject]) -> Void), failure failureBlock: @escaping ((AnyObject) -> Void)) {
    print("Calling mock API")
    
    successBlock( parsedArrayWithItem() ?? [ListObject]())
  }
  
  func parsedArrayWithItem() -> [ListObject]? {
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
